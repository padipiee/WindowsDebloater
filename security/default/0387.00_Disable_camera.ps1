

<#
.SYNOPSIS
This script disables the camera device 
# https://www.stigviewer.com/stig/microsoft_windows_11/2023-09-29/finding/V-253350
# https://www.stigviewer.com/stig/windows_10/2015-11-30/finding/V-63545
# https://www.stigviewer.com/stig/windows_10/2016-06-24/finding/V-63549
# CIS Windows ;;; 18.1.1.1 (L1) Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'

.DESCRIPTION
The script performs the following actions:
 Sets the registry value to prevent enabling the lock screen camera.

.PARAMETER None

.EXAMPLE
Runs the script  prevent enabling the lock screen camera.

.NOTES
- This script requires administrative privileges to run.
- The script is specifically designed for Windows 11.
#>


Write-Host "[0387.00_Disable_camera] List of camera with ok status"
Get-PnpDevice -PresentOnly -Class Camera,Image -Status OK | Format-List


Write-Host "[0387.00_Disable_camera] List of camera with Error status"
Get-PnpDevice -PresentOnly -Class Camera,Image -Status Error | Format-List

# Get the camera device instance ID
$cameraId = (Get-PnpDevice -Class Camera,Image  -Status Error).InstanceId

# Disable the camera device
Disable-PnpDevice -InstanceId $cameraId -Confirm:$false
Write-Host "[0387.00_Disable_camera] The value of '$propertyName' has been modified to '$targetValue'."

