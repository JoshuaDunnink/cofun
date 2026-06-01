@echo off
setlocal

set "DEPLOY_ENV=%~1"
if "%DEPLOY_ENV%"=="" set "DEPLOY_ENV=production"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0deploy.ps1" -DeployEnv %DEPLOY_ENV%
exit /b %ERRORLEVEL%
