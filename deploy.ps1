param(
  [switch]$SetupCredentials,
  [switch]$Build,
  [switch]$SkipBuild,
  [string]$FtpHost = $env:FTP_HOST,
  [string]$RemoteDir = $env:FTP_REMOTE_DIR,
  [string]$CredentialPath = (Join-Path $env:LOCALAPPDATA 'CoFun\deploy-ftp.cred.xml')
)

$ErrorActionPreference = 'Stop'

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

    if ($key -in @('FTP_HOST', 'FTP_REMOTE_DIR')) {
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

function Save-DeployCredential {
  param([string]$Path)

  $directory = Split-Path -Parent $Path
  if (-not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
  }

  $userName = Read-Host 'FTP username'
  $securePassword = Read-Host 'FTP password' -AsSecureString
  $credential = New-Object System.Management.Automation.PSCredential($userName, $securePassword)
  $credential | Export-Clixml -Path $Path

  Write-Host "==> Credential saved securely to $Path"
}

Load-EnvFile -Path '.env'

if (-not $FtpHost) {
  $FtpHost = $env:FTP_HOST
}

if (-not $RemoteDir) {
  $RemoteDir = $env:FTP_REMOTE_DIR
}

if ($SetupCredentials) {
  Save-DeployCredential -Path $CredentialPath
  return
}

if (-not $FtpHost) {
  throw 'FTP_HOST is required. Set it in .env or pass it as an environment variable.'
}

$remoteTarget = if ($RemoteDir) { $RemoteDir } else { '/cofun/cofun/__development/' }
$credential = Get-DeployCredential -Path $CredentialPath
$username = $credential.UserName
$password = $credential.GetNetworkCredential().Password

if ($Build -and $SkipBuild) {
  throw 'Use either -Build or -SkipBuild, not both.'
}

$distIndexPath = 'dist\index.html'

if ($Build) {
  Write-Host '==> Building site...'
  & npm run build
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }
}
elseif ($SkipBuild) {
  Write-Host '==> Skipping build; deploying existing dist output.'
  if (-not (Test-Path $distIndexPath)) {
    throw 'dist\index.html not found. Run npm run build first (or run deploy without -SkipBuild).'
  }
}
elseif (Test-Path $distIndexPath) {
  Write-Host '==> Using existing dist output (matches what preview serves).'
}
else {
  Write-Host '==> dist output not found; building site...'
  & npm run build
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }
}

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

$tempScript = [System.IO.Path]::GetTempFileName()
$normalizedRemoteTarget = $remoteTarget.Trim()
if (-not $normalizedRemoteTarget.StartsWith('/')) {
  $normalizedRemoteTarget = "/$normalizedRemoteTarget"
}
$normalizedRemoteTarget = $normalizedRemoteTarget.TrimEnd('/')

$mkdirCommands = @()
$runningPath = ''
foreach ($part in $normalizedRemoteTarget.Split('/', [System.StringSplitOptions]::RemoveEmptyEntries)) {
  $runningPath = "$runningPath/$part"
  $mkdirCommands += "mkdir `"$runningPath`""
}

$scriptLines = @(
  'option batch abort'
  'option confirm off'
  "open sftp://$username`:$password@$FtpHost/ -hostkey=*"
  'option batch continue'
)

$scriptLines += $mkdirCommands
$scriptLines += @(
  'option batch abort'
  "synchronize remote -delete `"dist`" `"$normalizedRemoteTarget`""
  'exit'
)

$scriptLines | Set-Content -Path $tempScript -Encoding ASCII

try {
  Write-Host "==> Deploying to $FtpHost"
  Write-Host "==> Target directory: $remoteTarget"

  & $winscpExecutable '/ini=nul' "/script=$tempScript"
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }
}
finally {
  Remove-Item -Path $tempScript -ErrorAction SilentlyContinue
}

Write-Host '==> Deployment complete!'
