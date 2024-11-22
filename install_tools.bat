@echo off
:: Script to Install Prerequisites, Microsoft Edge, Docker, and Podman on Windows Server 2019
:: Ensure this script is run as Administrator

echo ===========================================
echo Starting installation of prerequisites, Edge, Docker, and Podman...
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
if
