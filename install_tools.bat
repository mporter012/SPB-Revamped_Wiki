@echo off
:: Script to Install Prerequisites, Google Chrome, Docker, and Podman on Windows Server 2019
:: Ensure this script is run as Administrator

echo ===========================================
echo Starting installation of prerequisites, Chrome, Docker, and Podman...
echo ===========================================
echo.

:: 1. Install Windows Features (Hyper-V, Containers, and WSL2)
echo Enabling Windows features for Docker and Podman...
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart
if %ERRORLEVEL% equ 0 (
    echo Hyper-V feature enabled successfully!
) else (
    echo Failed to enable Hyper-V feature.
)

dism.exe /online /enable-feature /featurename:Containers /all /norestart
if %ERRORLEVEL% equ 0 (
    echo Containers feature enabled successfully!
) else (
    echo Failed to enable Containers feature.
)

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
if %ERRORLEVEL% equ 0 (
    echo Virtual Machine Platform enabled successfully!
) else (
    echo Failed to enable Virtual Machine Platform.
)

echo Installing Windows Subsystem for Linux (WSL2)...
wsl --install
if %ERRORLEVEL% equ 0 (
    echo WSL2 installed successfully!
) else (
    echo Failed to install WSL2.
)

echo.

:: 2. Update Windows
echo Checking for Windows Updates...
powershell -Command "Install-Module PSWindowsUpdate -Force -Confirm:$false; Import-Module PSWindowsUpdate; Install-WindowsUpdate -AcceptAll -AutoReboot"
if %ERRORLEVEL% equ 0 (
    echo Windows updates completed!
) else (
    echo Failed to update Windows. Proceeding with installations...
)

echo.

:: 3. Install Google Chrome
echo Downloading Google Chrome...
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile '%USERPROFILE%\Downloads\chrome_installer.exe'"

echo Installing Google Chrome...
start /wait "" "%USERPROFILE%\Downloads\chrome_installer.exe" /silent /install
if %ERRORLEVEL% equ 0 (
    echo Google Chrome installed successfully!
) else (
    echo Failed to install Google Chrome.
)

echo.

:: 4. Install Docker Desktop
echo Downloading Docker Desktop...
powershell -Command "Invoke-WebRequest -Uri 'https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe' -OutFile '%USERPROFILE%\Downloads\DockerDesktopInstaller.exe'"

echo Installing Docker Desktop...
start /wait "" "%USERPROFILE%\Downloads\DockerDesktopInstaller.exe" --quiet
if %ERRORLEVEL% equ 0 (
    echo Docker Desktop installed successfully!
) else (
    echo Failed to install Docker Desktop.
)

echo Configuring Docker to start automatically...
powershell -Command "& 'C:\Program Files\Docker\Docker\DockerCli.exe' -SwitchDaemon"
if %ERRORLEVEL% equ 0 (
    echo Docker configuration complete!
) else (
    echo Failed to configure Docker.
)

echo.

:: 5. Install Podman
echo Downloading Podman installer...
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/containers/podman/releases/download/v4.6.1/podman-v4.6.1.msi' -OutFile '%USERPROFILE%\Downloads\podman_installer.msi'"

echo Installing Podman...
msiexec /i "%USERPROFILE%\Downloads\podman_installer.msi" /quiet /norestart
if %ERRORLEVEL% equ 0 (
    echo Podman installed successfully!
) else (
    echo Failed to install Podman.
)

echo.

:: Final message
echo ===========================================
echo Installation of prerequisites, Chrome, Docker, and Podman completed!
echo Please restart your machine to ensure all changes are applied.
echo ===========================================
pause
