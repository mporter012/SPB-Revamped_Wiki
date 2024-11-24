@echo off
:: Script to Install Prerequisites, Google Chrome, Docker, and Podman on Windows Server 2019
:: Ensure this script is run as Administrator

set LOGFILE=%USERPROFILE%\install_log.txt
echo Installation started at %DATE% %TIME% > %LOGFILE%

echo ===========================================
echo Starting installation of prerequisites, Google Chrome, Docker, and Podman...
echo Check the log file at %LOGFILE% for details.
echo ===========================================

:: 1. Install Windows Features (Hyper-V, Containers, and WSL2)
echo Enabling Windows features for Docker and Podman... >> %LOGFILE%
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart >> %LOGFILE% 2>&1
if %ERRORLEVEL% neq 0 (
    echo Failed to enable Hyper-V feature. See log for details. >> %LOGFILE%
) else (
    echo Hyper-V feature enabled successfully! >> %LOGFILE%
)

dism.exe /online /enable-feature /featurename:Containers /all /norestart >> %LOGFILE% 2>&1
if %ERRORLEVEL% neq 0 (
    echo Failed to enable Containers feature. See log for details. >> %LOGFILE%
) else (
    echo Containers feature enabled successfully! >> %LOGFILE%
)

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart >> %LOGFILE% 2>&1
if %ERRORLEVEL% neq 0 (
    echo Failed to enable Virtual Machine Platform. See log for details. >> %LOGFILE%
) else (
    echo Virtual Machine Platform enabled successfully! >> %LOGFILE%
)

wsl --install >> %LOGFILE% 2>&1
if %ERRORLEVEL% neq 0 (
    echo Failed to install WSL2. See log for details. >> %LOGFILE%
) else (
    echo WSL2 installed successfully! >> %LOGFILE%
)

:: 2. Install Google Chrome
echo Downloading Google Chrome... >> %LOGFILE%
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile '%USERPROFILE%\Downloads\chrome_installer.exe'" >> %LOGFILE% 2>&1
if exist "%USERPROFILE%\Downloads\chrome_installer.exe" (
    echo Installing Google Chrome... >> %LOGFILE%
    start /wait "" "%USERPROFILE%\Downloads\chrome_installer.exe" /silent /install >> %LOGFILE% 2>&1
    if %ERRORLEVEL% neq 0 (
        echo Failed to install Google Chrome. See log for details. >> %LOGFILE%
    ) else (
        echo Google Chrome installed successfully! >> %LOGFILE%
    )
) else (
    echo Failed to download Google Chrome. File not found. >> %LOGFILE%
)

:: 3. Install Docker Desktop
echo Downloading Docker Desktop... >> %LOGFILE%
powershell -Command "Invoke-WebRequest -Uri 'https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe' -OutFile '%USERPROFILE%\Downloads\DockerDesktopInstaller.exe'" >> %LOGFILE% 2>&1
if exist "%USERPROFILE%\Downloads\DockerDesktopInstaller.exe" (
    echo Installing Docker Desktop... >> %LOGFILE%
    start /wait "" "%USERPROFILE%\Downloads\DockerDesktopInstaller.exe" --quiet >> %LOGFILE% 2>&1
    if %ERRORLEVEL% neq 0 (
        echo Failed to install Docker Desktop. See log for details. >> %LOGFILE%
    ) else (
        echo Docker Desktop installed successfully! >> %LOGFILE%
    )
) else (
    echo Failed to download Docker Desktop. File not found. >> %LOGFILE%
)

:: 4. Install Podman
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
