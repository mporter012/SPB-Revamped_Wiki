#!/bin/bash

# Variables
DOWNLOAD_URL="https://github.com/git-for-windows/git/releases/latest/download/Git-2.42.0-64-bit.exe"
DOWNLOAD_PATH="$HOME/Downloads/GitInstaller.exe"
LOGFILE="$HOME/git_install_log.txt"

echo "===========================================" | tee -a "$LOGFILE"
echo "Starting Git installation..." | tee -a "$LOGFILE"
echo "Log file: $LOGFILE" | tee -a "$LOGFILE"
echo "===========================================" | tee -a "$LOGFILE"

# Step 1: Download Git
echo "Downloading Git from $DOWNLOAD_URL..." | tee -a "$LOGFILE"
curl -L "$DOWNLOAD_URL" -o "$DOWNLOAD_PATH" 2>>"$LOGFILE"
if [ $? -eq 0 ] && [ -f "$DOWNLOAD_PATH" ]; then
    echo "Git installer downloaded successfully." | tee -a "$LOGFILE"
else
    echo "Failed to download Git installer. Check the log for details." | tee -a "$LOGFILE"
    exit 1
fi

# Step 2: Install Git
echo "Installing Git..." | tee -a "$LOGFILE"
"$DOWNLOAD_PATH" /SILENT >>"$LOGFILE" 2>&1
if [ $? -eq 0 ]; then
    echo "Git installed successfully." | tee -a "$LOGFILE"
else
    echo "Failed to install Git. Check the log for details." | tee -a "$LOGFILE"
    exit 1
fi

# Step 3: Verify Installation
echo "Verifying Git installation..." | tee -a "$LOGFILE"
git --version >>"$LOGFILE" 2>&1
if [ $? -eq 0 ]; then
    echo "Git installed and verified successfully." | tee -a "$LOGFILE"
else
    echo "Git verification failed. Git may not have installed correctly." | tee -a "$LOGFILE"
fi

echo "===========================================" | tee -a "$LOGFILE"
echo "Git installation process completed. Check the log file at $LOGFILE for details."
echo "==========================================="
