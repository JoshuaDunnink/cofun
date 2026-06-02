@echo off
setlocal

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0rollback.ps1" %*
exit /b %ERRORLEVEL%
