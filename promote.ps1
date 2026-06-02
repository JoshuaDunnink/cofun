param(
  [string]$FtpHost = $env:FTP_HOST,
  [string]$DevelopmentDir = $env:FTP_DEVELOPMENT_DIR,
  [string]$ProductionDir = $env:FTP_PRODUCTION_DIR,
  [string]$CredentialPath = (Join-Path $env:LOCALAPPDATA 'CoFun\deploy-ftp.cred.xml'),
  [string]$BackupDir = (Join-Path $env:LOCALAPPDATA 'CoFun\promote-backups')
)

$ErrorActionPreference = 'Stop'

$backupMetadataFile = Join-Path $BackupDir 'backups.json'
$astroConfigFile = 'astro.config.mjs'

function Load-EnvFile {
  param([string]$Path)
  if (-not (Test-Path $Path)) { return }
  Get-Content -Path $Path | ForEach-Object {
    $line = $_.Trim()
    if (-not $line -or $line.StartsWith('#')) { return }
    $parts = $line.Split('=', 2)
    if ($parts.Count -ne 2) { return }
    $key = $parts[0].Trim()
    $value = $parts[1].Trim()
    if (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) {
      $value = $value.Substring(1, $value.Length - 2)
    }
    if ($key -in @('FTP_HOST', 'FTP_DEVELOPMENT_DIR', 'FTP_PRODUCTION_DIR')) {
      [System.Environment]::SetEnvironmentVariable($key, $value)
    }
  }
}

function Get-DeployCredential {
  param([string]$Path)
  if (Test-Path $Path) {
    return Import-Clixml -Path $Path
  }
  throw "Secure FTP credential file not found at $Path. Run .\deploy.ps1 -SetupCredentials first."
}

function Update-AstroConfig {
  param([string]$ConfigPath, [string]$SiteUrl, [string]$BaseUrl)
  $config = Get-Content -Path $ConfigPath -Raw
  $config = $config -replace "site:\s*['\`"][^'\`"]*['\`"]", "site: '$SiteUrl'"
  $config = $config -replace "base:\s*['\`"][^'\`"]*['\`"]", "base: '$BaseUrl'"
  Set-Content -Path $ConfigPath -Value $config -NoNewline
}

function Backup-ProductionFiles {
  param([string]$BackupPath, [string]$FtpHost, [string]$Username, [string]$Password, [string]$SourceDir, [object]$WinscpExecutable)
  Write-Host "==> Creating backup of current production..."
  if (-not (Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
  }
  $tempScript = [System.IO.Path]::GetTempFileName()
  $normalizedSource = $SourceDir.Trim().TrimEnd('/')
  $scriptLines = @(
    'option batch abort'
    'option confirm off'
    "open sftp://$Username`:$Password@$FtpHost/ -hostkey=*"
    'option batch continue'
    'option batch abort'
    "synchronize local -delete `"$BackupPath`" `"$normalizedSource`""
    'exit'
  )
  $scriptLines | Set-Content -Path $tempScript -Encoding ASCII
  & $WinscpExecutable '/ini=nul' "/script=$tempScript" 2>&1 | Out-Null
  Remove-Item -Path $tempScript -ErrorAction SilentlyContinue
  return (Get-Item -Path $BackupPath -ErrorAction SilentlyContinue) -ne $null
}

function Save-BackupMetadata {
  param([string]$MetadataPath, [hashtable]$Metadata)
  $dir = Split-Path -Parent $MetadataPath
  if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
  }
  $backups = @()
  if (Test-Path $MetadataPath) {
    $backups = ConvertFrom-Json -InputObject (Get-Content -Path $MetadataPath -Raw)
    if (-not ($backups -is [array])) {
      $backups = @($backups)
    }
  }
  $backups += $Metadata
  $json = ConvertTo-Json -InputObject $backups -Depth 10
  Set-Content -Path $MetadataPath -Value $json
}

Load-EnvFile -Path '.env'

if (-not $FtpHost) { $FtpHost = $env:FTP_HOST }
if (-not $DevelopmentDir) { $DevelopmentDir = $env:FTP_DEVELOPMENT_DIR }
if (-not $ProductionDir) { $ProductionDir = $env:FTP_PRODUCTION_DIR }
if (-not $FtpHost) { throw 'FTP_HOST is required. Set it in .env or pass it as an environment variable.' }

$developmentTarget = if ($DevelopmentDir) { $DevelopmentDir } else { '/cofun/cofun/__development/' }
$productionTarget = if ($ProductionDir) { $ProductionDir } else { '/cofun/cofun/' }
$developmentSiteUrl = 'https://cofun.nl/cofun/__development/'
$developmentBase = '/cofun/__development/'
$productionSiteUrl = 'https://cofun.nl/'
$productionBase = '/'

$credential = Get-DeployCredential -Path $CredentialPath
$username = $credential.UserName
$password = $credential.GetNetworkCredential().Password

$winscpExecutable = $null
$winscpCommand = Get-Command winscp.com -ErrorAction SilentlyContinue
if ($winscpCommand) { $winscpExecutable = $winscpCommand.Source }

if (-not $winscpExecutable) {
  $candidatePaths = @(
    'C:\Program Files\WinSCP\WinSCP.com',
    'C:\Program Files (x86)\WinSCP\WinSCP.com',
    (Join-Path $env:LOCALAPPDATA 'Programs\WinSCP\WinSCP.com'),
    (Join-Path $env:LOCALAPPDATA 'Microsoft\WinGet\Links\WinSCP.com')
  )
  foreach ($candidatePath in $candidatePaths) {
    if (Test-Path $candidatePath) {
      $winscpExecutable = $candidatePath
      break
    }
  }
}

if (-not $winscpExecutable) {
  $wingetPackagesRoot = Join-Path $env:LOCALAPPDATA 'Microsoft\WinGet\Packages'
  if (Test-Path $wingetPackagesRoot) {
    $packageMatch = Get-ChildItem -Path $wingetPackagesRoot -Directory -Filter 'WinSCP.WinSCP*' -ErrorAction SilentlyContinue |
      Sort-Object LastWriteTime -Descending | Select-Object -First 1
    if ($packageMatch) {
      $packageWinScp = Join-Path $packageMatch.FullName 'WinSCP.com'
      if (Test-Path $packageWinScp) { $winscpExecutable = $packageWinScp }
    }
  }
}

if (-not $winscpExecutable) {
  throw 'WinSCP was not found. Install WinSCP first (for example: winget install WinSCP.WinSCP).'
}

$tempLocalDir = Join-Path $env:TEMP "cofun-promote-$(Get-Random)"
$backupTimestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backupPath = Join-Path $BackupDir "production-$backupTimestamp"

$originalConfig = $null

try {
  Write-Host "=========================================="
  Write-Host "  CoFun Site Promotion to Production"
  Write-Host "=========================================="
  Write-Host ""
  Write-Host "Source:      $developmentTarget"
  Write-Host "Target:      $productionTarget"
  Write-Host "Backup:      $backupPath"
  Write-Host ""

  Write-Host "==> Step 1/5: Backing up current production..."
  $backupSuccess = Backup-ProductionFiles -BackupPath $backupPath -FtpHost $FtpHost -Username $username -Password $password -SourceDir $productionTarget -WinscpExecutable $winscpExecutable
  
  if (-not $backupSuccess) {
    Write-Host "Warning: Backup may not have completed successfully. Continuing anyway..."
  }
  
  Write-Host "==> Step 2/5: Updating Astro configuration..."
  
  if (Test-Path $astroConfigFile) {
    $originalConfig = Get-Content -Path $astroConfigFile -Raw
    Update-AstroConfig -ConfigPath $astroConfigFile -SiteUrl $productionSiteUrl -BaseUrl $productionBase
    Write-Host "    * Updated site URL to: $productionSiteUrl"
    Write-Host "    * Updated base path to: $productionBase"
  }
  else {
    throw "Astro config file not found: $astroConfigFile"
  }

  Write-Host "==> Step 3/5: Rebuilding site for production..."
  & npm run build
  if ($LASTEXITCODE -ne 0) {
    throw "Build failed. Aborting promotion."
  }

  Write-Host "==> Step 4/5: Uploading files to production..."
  
  New-Item -ItemType Directory -Path $tempLocalDir -Force | Out-Null
  
  $normalizedProductionTarget = $productionTarget.Trim()
  if (-not $normalizedProductionTarget.StartsWith('/')) {
    $normalizedProductionTarget = "/$normalizedProductionTarget"
  }
  $normalizedProductionTarget = $normalizedProductionTarget.TrimEnd('/')

  $mkdirCommands = @()
  $runningPath = ''
  foreach ($part in $normalizedProductionTarget.Split('/', [System.StringSplitOptions]::RemoveEmptyEntries)) {
    $runningPath = "$runningPath/$part"
    $mkdirCommands += "mkdir `"$runningPath`""
  }
  
  $tempScript = [System.IO.Path]::GetTempFileName()
  $scriptLines = @(
    'option batch abort'
    'option confirm off'
    "open sftp://$username`:$password@$FtpHost/ -hostkey=*"
    'option batch continue'
  )
  
  $scriptLines += $mkdirCommands
  $scriptLines += @(
    'option batch abort'
    "synchronize remote -delete `"dist`" `"$normalizedProductionTarget`""
    'exit'
  )
  
  $scriptLines | Set-Content -Path $tempScript -Encoding ASCII
  
  & $winscpExecutable '/ini=nul' "/script=$tempScript"
  if ($LASTEXITCODE -ne 0) {
    throw "Failed to upload production files"
  }
  
  Remove-Item -Path $tempScript -ErrorAction SilentlyContinue

  Write-Host "==> Step 5/5: Cleaning up development directory..."
  
  $normalizedDevelopmentTarget = $developmentTarget.Trim()
  if (-not $normalizedDevelopmentTarget.StartsWith('/')) {
    $normalizedDevelopmentTarget = "/$normalizedDevelopmentTarget"
  }
  $normalizedDevelopmentTarget = $normalizedDevelopmentTarget.TrimEnd('/')
  
  $tempScript = [System.IO.Path]::GetTempFileName()
  $scriptLines = @(
    'option batch abort'
    'option confirm off'
    "open sftp://$username`:$password@$FtpHost/ -hostkey=*"
    'option batch continue'
    'option batch abort'
    "rmdir -f -r `"$normalizedDevelopmentTarget`""
    'exit'
  )
  
  $scriptLines | Set-Content -Path $tempScript -Encoding ASCII
  
  & $winscpExecutable '/ini=nul' "/script=$tempScript" 2>&1 | Out-Null
  Remove-Item -Path $tempScript -ErrorAction SilentlyContinue

  Write-Host ""
  Write-Host "** IMPORTANT: Clear your browser cache! **"
  Write-Host "   The old development site may be cached in your browser."
  Write-Host "   Press Ctrl+Shift+Delete to clear browser cache and cookies."
  Write-Host "   Then refresh the page: Ctrl+F5 (hard refresh)"
  Write-Host ""

  $promotionDate = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
  $metadata = @{
    timestamp = $backupTimestamp
    backup_path = $backupPath
    promotion_date = $promotionDate
    development_dir = $developmentTarget
    production_dir = $productionTarget
  }
  
  Save-BackupMetadata -MetadataPath $backupMetadataFile -Metadata $metadata
  
  Write-Host ""
  Write-Host "=========================================="
  Write-Host "  * Promotion Complete!"
  Write-Host "=========================================="
  Write-Host ""
  Write-Host "Your site is now live in production!"
  Write-Host "Backup ID: $backupTimestamp"
  Write-Host ""
  Write-Host "To rollback if needed, run:"
  Write-Host "  .\rollback.ps1 -BackupId $backupTimestamp"
  Write-Host ""
}
catch {
  Write-Host ""
  Write-Host "  * Promotion failed: $_" -ForegroundColor Red
  Write-Host ""
  Write-Host "Attempting to restore Astro config..."
  if ((Test-Path $astroConfigFile) -and ($null -ne $originalConfig)) {
    Update-AstroConfig -ConfigPath $astroConfigFile -SiteUrl $developmentSiteUrl -BaseUrl $developmentBase
    Write-Host "  * Astro config restored to development settings"
  }
  
  exit 1
}
finally {
  if (Test-Path $tempLocalDir) {
    Remove-Item -Path $tempLocalDir -Recurse -Force -ErrorAction SilentlyContinue
  }
}
