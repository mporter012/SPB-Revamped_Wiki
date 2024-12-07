@echo off
:: Script to Install Docker and Podman on Windows Server 2019
:: Ensure this script is run as Administrator

set LOGFILE=%USERPROFILE%\install_log.txt
echo Installation started at %DATE% %TIME% > %LOGFILE%

:: 1. Install Docker Desktop
echo Downloading Docker Desktop... >> %LOGFILE%
curl -L -o "%USERPROFILE%\Downloads\DockerDesktopInstaller.exe" "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-win-amd64" >> %LOGFILE% 2>&1

if exist "%USERPROFILE%\Downloads\DockerDesktopInstaller.exe" (
    echo Installing Docker Desktop... >> %LOGFILE%
    start /wait "" "%USERPROFILE%\Downloads\DockerDesktopInstaller.exe" --quiet >> %LOGFILE% 2>&1
    if %ERRORLEVEL% neq 0 (
        echo Failed to install Docker Desktop. Check %LOGFILE% for details. >> %LOGFILE%
    ) else (
        echo Docker Desktop installed successfully! >> %LOGFILE%
    )
) else (
    echo Failed to download Docker Desktop. File not found. >> %LOGFILE%
)

:: 2. Install Podman
echo Downloading Podman installer... >> %LOGFILE%
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/containers/podman/releases/download/v4.6.1/podman-v4.6.1.msi' -OutFile '%USERPROFILE%\Downloads\podman_installer.msi'" >> %LOGFILE% 2>&1
if exist "%USERPROFILE%\Downloads\podman_installer.msi" (
    echo Installing Podman... >> %LOGFILE%
    msiexec /i "%USERPROFILE%\Downloads\podman_installer.msi" /quiet /norestart >> %LOGFILE% 2>&1
    if %ERRORLEVEL% neq 0 (
        echo Failed to install Podman. See log for details. >> %LOGFILE%
    ) else (
        echo Podman installed successfully! >> %LOGFILE%
    )
) else (
    echo Failed to download Podman. File not found. >> %LOGFILE%
)

:: Final message
echo ===========================================
echo Installation completed. Please check the log file at %LOGFILE% for details.
echo Please restart your machine to ensure all changes are applied.
echo ===========================================
pause
