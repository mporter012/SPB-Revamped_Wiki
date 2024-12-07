# This script will install Docker on Windows Server 2019 based on the tutorial from https://4sysops.com/archives/install-docker-on-windows-server-2019/

# Ensure you are running this script as Administrator.

# Set log file location
$logfile = "$env:USERPROFILE\docker_install_log.txt"
$dockerVersion = "20.10.7"
$dockerUrl = "https://download.docker.com/win/static/stable/x86_64/docker-$dockerVersion.zip"
$downloadDir = "$env:USERPROFILE\Downloads"
$dockerZipPath = "$downloadDir\docker-$dockerVersion.zip"
$dockerExtractPath = "$env:ProgramFiles\Docker"

# Logging function for simplicity
function Log-Message {
    param([string]$message)
    Write-Host $message
    Add-Content -Path $logfile -Value "$message `r`n"
}

# Step 1: Download Docker Installer
Log-Message "Downloading Docker from $dockerUrl..."
try {
    Invoke-WebRequest -Uri $dockerUrl -OutFile $dockerZipPath
    Log-Message "Docker downloaded successfully!"
} catch {
    Log-Message "Failed to download Docker. Error: $_"
    exit
}

# Step 2: Extract Docker to Program Files
Log-Message "Extracting Docker to $dockerExtractPath..."
try {
    Expand-Archive -Path $dockerZipPath -DestinationPath $dockerExtractPath -Force
    Log-Message "Docker extracted successfully!"
} catch {
    Log-Message "Failed to extract Docker. Error: $_"
    exit
}

# Step 3: Add Docker to the System PATH
Log-Message "Adding Docker to system PATH..."
$env:Path += ";$dockerExtractPath\docker"
[Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::Machine)

# Step 4: Install Docker Daemon as a Service
Log-Message "Installing Docker daemon as a service..."
$dockerServicePath = "$dockerExtractPath\docker\docker.exe"
$dockerServiceArgs = "run --privileged --name docker --restart=unless-stopped"
New-Service -Name "docker" -Binary $dockerServicePath -ArgumentList $dockerServiceArgs -DisplayName "Docker Service" -StartupType Automatic

# Step 5: Start Docker Service
Log-Message "Starting Docker service..."
Start-Service -Name "docker"

# Step 6: Verify Docker Installation
Log-Message "Verifying Docker installation..."
try {
    docker --version
    Log-Message "Docker installed and running successfully!"
} catch {
    Log-Message "Docker installation verification failed. Error: $_"
}

Log-Message "Docker installation completed. Please check the log file at $logfile for more details."
