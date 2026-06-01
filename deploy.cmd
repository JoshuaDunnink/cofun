@echo off
setlocal

if /I "%~1"=="setup" (
  powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1" -SetupCredentials
  exit /b %ERRORLEVEL%
)

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1" %*
exit /b %ERRORLEVEL%
