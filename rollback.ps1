param(
  [string]$BackupId,
  [string]$FtpHost = $env:FTP_HOST,
  [string]$ProductionDir = $env:FTP_PRODUCTION_DIR,
  [string]$CredentialPath = (Join-Path $env:LOCALAPPDATA 'CoFun\deploy-ftp.cred.xml'),
  [string]$BackupDir = (Join-Path $env:LOCALAPPDATA 'CoFun\promote-backups')
)

$ErrorActionPreference = 'Stop'

# Backup metadata
$backupMetadataFile = Join-Path $BackupDir 'backups.json'
$astroConfigFile = 'astro.config.mjs'

function Load-EnvFile {
  param([string]$Path)

  if (-not (Test-Path $Path)) {
    return
  }

  Get-Content -Path $Path | ForEach-Object {
    $line = $_.Trim()
    if (-not $line -or $line.StartsWith('#')) {
      return
    }

    $parts = $line.Split('=', 2)
    if ($parts.Count -ne 2) {
      return
    }

    $key = $parts[0].Trim()
    $value = $parts[1].Trim()

    if (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) {
      $value = $value.Substring(1, $value.Length - 2)
    }

    if ($key -in @('FTP_HOST', 'FTP_PRODUCTION_DIR')) {
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
  param(
    [string]$ConfigPath,
    [string]$SiteUrl,
    [string]$BaseUrl
  )
  
  $config = Get-Content -Path $ConfigPath -Raw
  
  # Update site URL
  $config = $config -replace "site:\s*['\`"]https://cofun\.nl[^'\`"]*['\`"]", "site: '$SiteUrl'"
  
  # Update base path
  $config = $config -replace "base:\s*['\`"][^'\`"]*['\`"]", "base: '$BaseUrl'"
  
  Set-Content -Path $ConfigPath -Value $config -NoNewline
}

function List-Backups {
  param([string]$MetadataPath)
  
  if (-not (Test-Path $MetadataPath)) {
    Write-Host "No backups found."
    return @()
  }
  
  $backups = ConvertFrom-Json -InputObject (Get-Content -Path $MetadataPath -Raw)
  if (-not ($backups -is [array])) {
    $backups = @($backups)
  }
  
  return $backups
}

Load-EnvFile -Path '.env'

if (-not $FtpHost) {
  $FtpHost = $env:FTP_HOST
}

if (-not $ProductionDir) {
  $ProductionDir = $env:FTP_PRODUCTION_DIR
}

if (-not $FtpHost) {
  throw 'FTP_HOST is required. Set it in .env or pass it as an environment variable.'
}

$productionTarget = if ($ProductionDir) { $ProductionDir } else { '/cofun/cofun/' }
$developmentSiteUrl = 'https://cofun.nl/cofun/__development/'
$developmentBase = '/cofun/__development/'

# If no BackupId provided, list available backups
if (-not $BackupId) {
  Write-Host "=========================================="
  Write-Host "  Available Backups"
  Write-Host "=========================================="
  Write-Host ""
  
  $backups = List-Backups -MetadataPath $backupMetadataFile
  
  if ($backups.Count -eq 0) {
    Write-Host "No backups available."
    exit 1
  }
  
  $backups | ForEach-Object {
    Write-Host "ID:       $($_.timestamp)"
    Write-Host "Date:     $($_.promotion_date)"
    Write-Host "Backup:   $($_.backup_path)"
    Write-Host ""
  }
  
  Write-Host "To rollback, run:"
  Write-Host "  .\rollback.ps1 -BackupId <ID>"
  Write-Host ""
  exit 0
}

# Verify backup exists
$backups = List-Backups -MetadataPath $backupMetadataFile
$selectedBackup = $backups | Where-Object { $_.timestamp -eq $BackupId } | Select-Object -First 1

if (-not $selectedBackup) {
  Write-Host "✗ Backup not found: $BackupId" -ForegroundColor Red
  Write-Host ""
  Write-Host "Available backups:"
  $backups | ForEach-Object {
    Write-Host "  - $($_.timestamp)"
  }
  exit 1
}

if (-not (Test-Path $selectedBackup.backup_path)) {
  Write-Host "✗ Backup files not found: $($selectedBackup.backup_path)" -ForegroundColor Red
  exit 1
}

$credential = Get-DeployCredential -Path $CredentialPath
$username = $credential.UserName
$password = $credential.GetNetworkCredential().Password

$winscpExecutable = $null
$winscpCommand = Get-Command winscp.com -ErrorAction SilentlyContinue
if ($winscpCommand) {
  $winscpExecutable = $winscpCommand.Source
}

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
      Sort-Object LastWriteTime -Descending |
      Select-Object -First 1

    if ($packageMatch) {
      $packageWinScp = Join-Path $packageMatch.FullName 'WinSCP.com'
      if (Test-Path $packageWinScp) {
        $winscpExecutable = $packageWinScp
      }
    }
  }
}

if (-not $winscpExecutable) {
  throw 'WinSCP was not found. Install WinSCP first (for example: winget install WinSCP.WinSCP).'
}

try {
  Write-Host "=========================================="
  Write-Host "  CoFun Site Rollback"
  Write-Host "=========================================="
  Write-Host ""
  Write-Host "Backup ID:  $BackupId"
  Write-Host "Backup:     $($selectedBackup.backup_path)"
  Write-Host "Target:     $productionTarget"
  Write-Host ""
  
  $confirmation = Read-Host "Are you sure you want to rollback? (yes/no)"
  
  if ($confirmation -ne 'yes') {
    Write-Host "Rollback cancelled."
    exit 0
  }

  # Step 1: Restore Astro config to development settings
  Write-Host ""
  Write-Host "==> Step 1/2: Restoring Astro configuration to development settings..."
  
  if (Test-Path $astroConfigFile) {
    Update-AstroConfig -ConfigPath $astroConfigFile -SiteUrl $developmentSiteUrl -BaseUrl $developmentBase
    Write-Host "    ✓ Updated site URL to: $developmentSiteUrl"
    Write-Host "    ✓ Updated base path to: $developmentBase"
  }

  # Step 2: Restore backup files
  Write-Host "==> Step 2/2: Restoring backup files to production..."
  
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
    "synchronize remote -delete `"$($selectedBackup.backup_path)`" `"$normalizedProductionTarget`""
    'exit'
  )
  
  $scriptLines | Set-Content -Path $tempScript -Encoding ASCII
  
  & $winscpExecutable '/ini=nul' "/script=$tempScript"
  if ($LASTEXITCODE -ne 0) {
    throw "Failed to restore backup files"
  }
  
  Remove-Item -Path $tempScript -ErrorAction SilentlyContinue

  Write-Host ""
  Write-Host "=========================================="
  Write-Host "✓ Rollback Complete!"
  Write-Host "=========================================="
  Write-Host ""
  Write-Host "Your site has been restored to the previous version."
  Write-Host ""
}
catch {
  Write-Host ""
  Write-Host "✗ Rollback failed: $_" -ForegroundColor Red
  Write-Host ""
  exit 1
}
