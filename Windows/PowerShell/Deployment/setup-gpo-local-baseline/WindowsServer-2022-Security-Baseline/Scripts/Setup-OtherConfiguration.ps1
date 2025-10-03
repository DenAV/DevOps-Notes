# Setup othe configuration
# This script is used to setup other configuration

# 
######################################
# Event-ID 131 DeviceSetupManager - Windows is retrieving device metadata from the Internet
# Set the policy to prevent Windows from retrieving device metadata from the Internet
######################################
Write-Host "-----------------------------------------------------------------------------------" -ForegroundColor Green
Write-Host "Setting the policy to prevent Windows from retrieving device metadata from the Internet..."
Write-Host "-----------------------------------------------------------------------------------"

# Path to the registry key
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows\Device Metadata"

# backup the current registry settings
try {
    # Create the backup directory if it doesn't exist
    $backupPath = "C:\Scripts\RegistryBackup"
    if (-not (Test-Path $backupPath -PathType Container)) {
        New-Item -Path $backupPath -ItemType Directory
    }

    $backupFile = "$backupPath\RegistryBackup_PreventDeviceMetadataFromNetwork_$(Get-Date -Format 'yyyyMMdd_HHmmss').reg"

    if (Test-Path $registryPath) {
        Write-Host "Backing up the current registry settings to $backupFile..."
        reg export "HKLM\Software\Policies\Microsoft\Windows\Device Metadata" $backupFile /y
    } else {
        Write-Host "The registry key does not exist. No backup is needed."
    }

} catch {
    Write-Host "Failed to backup the current registry settings." -ForegroundColor Red
    return
}

# Create the registry key if it does not exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the policy to prevent Windows from retrieving device metadata from the Internet
# 0x1 (Enable the policy: Prevent retrieving device metadata)
Set-ItemProperty -Path $registryPath -Name "PreventDeviceMetadataFromNetwork" -Value 0x1 -Type DWord -Force

Write-Host "Policy has been set to prevent Windows from retrieving device metadata from the Internet." -ForegroundColor Yellow
Write-Host "-----------------------------------------------------------------------------------" -ForegroundColor Green