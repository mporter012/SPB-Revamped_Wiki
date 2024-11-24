@echo off
:: Script to check if Google Chrome, Podman, and Docker are installed on Windows
:: Ensure this script is run as Administrator

set LOGFILE=%USERPROFILE%\install_check_log.txt
echo Installation check started at %DATE% %TIME% > %LOGFILE%

echo ===========================================
echo Checking installation of Google Chrome, Podman, and Docker...
echo ===========================================

:: Check Google Chrome
echo Checking for Google Chrome... >> %LOGFILE%
:: Look in both user and system registry locations
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "Google Chrome" >nul 2>&1
if %ERRORLEVEL% neq 0 (
    reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "Google Chrome" >nul 2>&1
)
if %ERRORLEVEL% equ 0 (
    echo Google Chrome is installed. >> %LOGFILE%
    echo Google Chrome: Installed
) else (
    echo Google Chrome is not installed. >> %LOGFILE%
    echo Google Chrome: Not Installed
)

:: Check Podman
echo Checking for Podman... >> %LOGFILE%
powershell -Command "Get-Command podman -ErrorAction SilentlyContinue" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Podman is installed. >> %LOGFILE%
    echo Podman: Installed
) else (
    echo Podman is not installed. >> %LOGFILE%
    echo Podman: Not Installed
)

:: Check Docker
echo Checking for Docker... >> %LOGFILE%
powershell -Command "Get-Command docker -ErrorAction SilentlyContinue" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo Docker is installed. >> %LOGFILE%
    echo Docker: Installed
) else (
    echo Docker is not installed. >> %LOGFILE%
    echo Docker: Not Installed
)

echo ===========================================
echo Check completed. Results saved to %LOGFILE%.
echo ===========================================
pause
