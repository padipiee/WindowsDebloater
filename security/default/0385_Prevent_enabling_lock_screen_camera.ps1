

<#
.SYNOPSIS
This script disables the camera device and prevents enabling the lock screen camera on Windows 10/11.
# https://www.stigviewer.com/stig/microsoft_windows_11/2023-09-29/finding/V-253350
# https://www.stigviewer.com/stig/windows_10/2015-11-30/finding/V-63545
# https://www.stigviewer.com/stig/windows_10/2016-06-24/finding/V-63549
# CIS Windows ;;; 18.1.1.1 (L1) Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'

.DESCRIPTION
The script performs the following actions:
1. Retrieves the camera device instance ID.
2. Disables the camera device.
3. Sets the registry value to prevent enabling the lock screen camera.

.PARAMETER None

.EXAMPLE
.\0385_Prevent_enabling_lock_screen_camera.ps1
Runs the script to disable the camera device and prevent enabling the lock screen camera.

.NOTES
- This script requires administrative privileges to run.
- The script is specifically designed for Windows 11.
#>

Get-PnpDevice -PresentOnly -Class Camera,Image -Status OK | Format-List

# Get the camera device instance ID
$cameraId = (Get-PnpDevice -Class Camera,Image  -Status OK).InstanceId

# Disable the camera device
Disable-PnpDevice -InstanceId $cameraId -Confirm:$false

# Set the registry value to prevent enabling lock screen camera
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows\Personalization"
$propertyName = "NoLockScreenCamera"
$targetValue = 1

# Check if the registry key exists
if (-not (Test-Path -Path $registryPath)) {
    # If the registry key does not exist, create it
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "[0385_Prevent_enabling_lock_screen_camera] $registryPath was created."
}

$currentValue = Get-ItemPropertyValue -Path $registryPath -Name $propertyName -ErrorAction SilentlyContinue

if ($currentValue -eq $targetValue) {
    Write-Host "[0385_Prevent_enabling_lock_screen_camera] The value of '$propertyName' is already set to '$targetValue'. No changes were made."
} else {
    Set-ItemProperty -Path $registryPath -Name $propertyName -Value $targetValue -Type DWord
    Write-Host "[0385_Prevent_enabling_lock_screen_camera] The value of '$propertyName' has been modified to '$targetValue'."
}
