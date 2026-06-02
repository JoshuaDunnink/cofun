@echo off
setlocal

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0promote.ps1" %*
exit /b %ERRORLEVEL%
