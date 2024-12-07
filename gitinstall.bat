@echo off
:: Script to download and install Git on Windows
:: Ensure this script is run as Administrator

set DOWNLOAD_URL=https://github.com/git-for-windows/git/releases/latest/download/Git-2.42.0-64-bit.exe
set DOWNLOAD_PATH=%USERPROFILE%\Downloads\GitInstaller.exe
set LOGFILE=%USERPROFILE%\git_install_log.txt

echo ===========================================
echo Starting Git installation...
echo Log file: %LOGFILE%
echo ===========================================
echo Installation started at %DATE% %TIME% > %LOGFILE%

:: Step 1: Download Git
echo Downloading Git from %DOWNLOAD_URL%... >> %LOGFILE%
powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%DOWNLOAD_PATH%'" >> %LOGFILE% 2>&1
if exist "%DOWNLOAD_PATH%" (
    echo Git installer downloaded successfully. >> %LOGFILE%
    echo Git installer downloaded successfully.
) else (
    echo Failed to download Git installer. See log for details. >> %LOGFILE%
    echo Failed to download Git installer. See log for details.
    pause
    exit /b 1
)

:: Step 2: Install Git
echo Installing Git... >> %LOGFILE%
start /wait "" "%DOWNLOAD_PATH%" /SILENT >> %LOGFILE% 2>&1
if %ERRORLEVEL% equ 0 (
    echo Git installed successfully. >> %LOGFILE%
    echo Git installed successfully.
) else (
    echo Failed to install Git. See log for details. >> %LOGFILE%
    echo Failed to install Git. See log for details.
    pause
    exit /b 1
)

:: Step 3: Verify Installation
echo Verifying Git installation... >> %LOGFILE%
git --version >> %LOGFILE% 2>&1
if %ERRORLEVEL% equ 0 (
    echo Git verification successful. Git installed and working. >> %LOGFILE%
    echo Git verification successful. Git installed and working.
) else (
    echo Git verification failed. Git may not have installed correctly. >> %LOGFILE%
    echo Git verification failed. Git may not have installed correctly.
)

echo ===========================================
echo Git installation process completed. Check the log file at %LOGFILE% for details.
echo ===========================================
pause
