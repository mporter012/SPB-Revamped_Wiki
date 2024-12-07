@echo off
set LOGFILE=%USERPROFILE%\install_log.txt
echo Installation started at %DATE% %TIME% > %LOGFILE%

echo ===========================================
echo Starting installation of Docker and Podman...
echo Check the log file at %LOGFILE% for details.
echo ===========================================

:: 1. Enable Windows Features (Hyper-V, Containers, and WSL2)
echo Enabling Windows features for Docker and Podman... >> %LOGFILE%
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart >> %LOGFILE% 2>&1
dism.exe /online /enable-feature /featurename:Containers /all /norestart >> %LOGFILE% 2>&1
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart >> %LOGFILE% 2>&1
wsl --install >> %LOGFILE% 2>&1

:: 2. Install Docker Desktop
echo Downloading Docker Desktop... >> %LOGFILE%
powershell -Command "Invoke-WebRequest -Uri 'https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe' -OutFile '%USERPROFILE%\Downloads\DockerDesktopInstaller.exe'" >> %LOGFILE% 2>&1
if exist "%USERPROFILE%\Downloads\DockerDesktopInstaller.exe" (
    echo Installing Docker Desktop... >> %LOGFILE%
    start /wait "" "%USERPROFILE%\Downloads\DockerDesktopInstaller.exe" --quiet >> %LOGFILE% 2>&1
    if %ERRORLEVEL% neq 0 (
        echo Docker Desktop installation failed. See log for details. >> %LOGFILE%
    ) else (
        echo Docker Desktop installed successfully! >> %LOGFILE%
        echo Configuring Docker CLI...
        "C:\Program Files\Docker\Docker\DockerCli.exe" -SwitchDaemon >> %LOGFILE% 2>&1
    )
) else (
    echo Failed to download Docker Desktop. File not found. >> %LOGFILE%
)

:: 3. Install Podman
echo Downloading Podman installer... >> %LOGFILE%
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/containers/podman/releases/download/v4.6.1/podman-v4.6.1.msi' -OutFile '%USERPROFILE%\Downloads\podman_installer.msi'" >> %LOGFILE% 2>&1
if exist "%USERPROFILE%\Downloads\podman_installer.msi" (
    msiexec /i "%USERPROFILE%\Downloads\podman_installer.msi" /quiet /norestart >> %LOGFILE% 2>&1
    if %ERRORLEVEL% neq 0 (
        echo Podman installation failed. See log for details. >> %LOGFILE%
    ) else (
        echo Podman installed successfully! >> %LOGFILE%
        echo Adding Podman to PATH...
        setx PATH "%PATH%;C:\Program Files\RedHat\Podman" >> %LOGFILE% 2>&1
    )
) else (
    echo Failed to download Podman. File not found. >> %LOGFILE%
)

echo ===========================================
echo Installation completed. Please check the log file at %LOGFILE% for details.
echo ===========================================
pause
