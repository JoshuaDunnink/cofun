param(
  [ValidateSet('production', 'staging')]
  [string]$DeployEnv = 'production'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path '.env')) {
  Write-Error 'Error: .env file not found. Copy .env.example and fill in your credentials.'
}

function Load-EnvFile {
  param([string]$Path)

  Get-Content -Path $Path | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith('#')) {
      $parts = $line.Split('=', 2)
      if ($parts.Count -eq 2) {
        $key = $parts[0].Trim()
        $value = $parts[1].Trim()

        if (($value.StartsWith('"') -and $value.EndsWith('"')) -or ($value.StartsWith("'") -and $value.EndsWith("'"))) {
          $value = $value.Substring(1, $value.Length - 2)
        }

        [System.Environment]::SetEnvironmentVariable($key, $value)
      }
    }
  }
}

Load-EnvFile -Path '.env'

if (-not $env:FTP_HOST -or -not $env:FTP_USER -or -not $env:FTP_PASS) {
  Write-Error 'Error: FTP_HOST, FTP_USER, and FTP_PASS must be set in .env'
}

if ($DeployEnv -eq 'staging') {
  $buildScript = 'build:staging'
  $defaultRemoteDir = '/httpdocs/cofun/__development/'
}
else {
  $buildScript = 'build:prod'
  $defaultRemoteDir = '/httpdocs/'
}

$remoteDir = if ($env:FTP_REMOTE_DIR) { $env:FTP_REMOTE_DIR } else { $defaultRemoteDir }

Write-Host "==> Environment: $DeployEnv"
Write-Host "==> Building site (npm run $buildScript)..."
& npm run $buildScript
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}

$winscpCommand = Get-Command winscp.com -ErrorAction SilentlyContinue
if (-not $winscpCommand) {
  Write-Error "Error: winscp.com not found. Install WinSCP first. Example: winget install WinSCP.WinSCP"
}

Write-Host "==> Deploying to $($env:FTP_HOST)..."
Write-Host "==> Target directory: $remoteDir"

$encodedUser = [Uri]::EscapeDataString($env:FTP_USER)
$encodedPass = [Uri]::EscapeDataString($env:FTP_PASS)
$openTarget = "sftp://${encodedUser}:${encodedPass}@$($env:FTP_HOST)/"

$tempScript = [System.IO.Path]::GetTempFileName()
@(
  'option batch abort'
  'option confirm off'
  "open `"$openTarget`" -hostkey=*"
  "synchronize remote -delete `"dist`" `"$remoteDir`""
  'exit'
) | Set-Content -Path $tempScript -Encoding ASCII

try {
  & $winscpCommand.Source '/ini=nul' "/script=$tempScript"
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }
}
finally {
  Remove-Item -Path $tempScript -ErrorAction SilentlyContinue
}

Write-Host '==> Deployment complete!'
