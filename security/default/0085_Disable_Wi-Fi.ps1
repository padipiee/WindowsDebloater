<#
.SYNOPSIS
Disables Wi-Fi settings related to Wi-Fi Sense and Auto Connect in the Windows registry.

.DESCRIPTION
This script disables specific Wi-Fi settings in the Windows registry. It checks if the registry items exist and if their values are already set to the target value. If the values are not set, it updates the registry with the target value to disable the corresponding Wi-Fi settings.

.PARAMETER regPath1
The registry path for the first Wi-Fi setting.

.PARAMETER regPath2
The registry path for the second Wi-Fi setting.

.PARAMETER regPath3
The registry path for the third Wi-Fi setting.

.PARAMETER targetValue
The target value to set in the registry to disable the Wi-Fi settings.

.NOTES
- This script requires administrative privileges to modify the Windows registry.
- It is recommended to run this script with caution and understand the implications of disabling Wi-Fi settings.

.EXAMPLE
Disable-WiFiSettings -regPath1 "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -regPath2 "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -regPath3 "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -targetValue 0
#>
$regPath1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
$regPath2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
$regPath3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
$targetValue = 0

# Check if registry items exist
if ((Test-Path $regPath1) -or (Test-Path $regPath2) -or (Test-Path $regPath3)) {
    # Check the value of each registry item
    $value1 = Get-ItemProperty -Path $regPath1 -Name "value" -ErrorAction SilentlyContinue
    $value2 = Get-ItemProperty -Path $regPath2 -Name "value" -ErrorAction SilentlyContinue
    $value3 = Get-ItemProperty -Path $regPath3 -Name "AutoConnectAllowedOEM" -ErrorAction SilentlyContinue

    # Check if the values are already set to the target value
    if ($value1 -and $value1.value -eq $targetValue) {
        Write-Host "[0085_Disable_Wi-Fi] Wi-Fi Sense is already disabled."
    }
    if ($value2 -and $value2.value -eq $targetValue) {
        Write-Host "[0085_Disable_Wi-Fi] Auto Connect to Wi-Fi Sense Hotspots is already disabled."
    }
    if ($value3 -and $value3.AutoConnectAllowedOEM -eq $targetValue) {
        Write-Host "[0085_Disable_Wi-Fi] Auto Connect Allowed OEM is already disabled."
    }

    # Set the values to the target value if needed
    if ($value1 -and $value1.value -ne $targetValue) {
        Set-ItemProperty -Path $regPath1 -Name "value" -Value $targetValue -Force
        Write-Host "[0085_Disable_Wi-Fi] Wi-Fi Sense has been disabled."
    }
    if ($value2 -and $value2.value -ne $targetValue) {
        Set-ItemProperty -Path $regPath2 -Name "value" -Value $targetValue -Force
        Write-Host "[0085_Disable_Wi-Fi] Auto Connect to Wi-Fi Sense Hotspots has been disabled."
    }
    if ($value3 -and $value3.AutoConnectAllowedOEM -ne $targetValue) {
        Set-ItemProperty -Path $regPath3 -Name "AutoConnectAllowedOEM" -Value $targetValue -Force
        Write-Host "[0085_Disable_Wi-Fi] Auto Connect Allowed OEM has been disabled."
    }
}
else {
    Write-Host "[0085_Disable_Wi-Fi] Registry items not found."
}
