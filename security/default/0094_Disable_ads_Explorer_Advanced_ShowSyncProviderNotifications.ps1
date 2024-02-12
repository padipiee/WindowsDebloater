<#
.SYNOPSIS
Disables ads in Windows 10 by disabling Windows Consumer Features (App Suggestions on Start).

.DESCRIPTION
This script disables the "ShowSyncProviderNotifications" feature in the Windows registry, which is responsible for displaying ads in Windows 10. It checks if the registry key exists and if the value is already set to the desired target value. If not, it sets the value to the target value.

.PARAMETER None

.EXAMPLE
Disable-Ads

This example runs the script to disable ads in Windows 10.

.NOTES
- This script requires administrative privileges to modify the Windows registry.
- This script is referenced by "0094_Disable_ads_Explorer_Advanced_ShowSyncProviderNotifications.ps1".
- This script references "0075_Disassembler0_Win10-Initial-Setup-Script.ps1" and "0037_Disable_Windows_Consumer_Features.bat".
#>
# REM Disable ads in Windows 10 - Disable Windows Consumer Features (App Suggestions on Start) 
# REM ##REF 1  Powershell : 0075_Disassembler0_Win10-Initial-Setup-Script.ps1
# REM ##REF 2  Batch : 0037_Disable_Windows_Consumer_Features.bat

# REM [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced] "ShowSyncProviderNotifications"=dword:00000000
$keyPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
$valueName = "ShowSyncProviderNotifications"
$targetValue = 0

if (Test-Path $keyPath) {
    $currentValue = Get-ItemProperty -Path $keyPath -Name $valueName -ErrorAction SilentlyContinue
    if ($currentValue -and $currentValue.$valueName -eq $targetValue) {
        Write-Host "[0094_Disable_ads_Explorer_Advanced_ShowSyncProviderNotifications] The value $valueName is already set to $targetValue."
    }
    else {
        Set-ItemProperty -Path $keyPath -Name $valueName -Value $targetValue
        Write-Host "[0094_Disable_ads_Explorer_Advanced_ShowSyncProviderNotifications] The value $valueName has been set to $targetValue."
    }
}
else {
    Write-Host "[0094_Disable_ads_Explorer_Advanced_ShowSyncProviderNotifications] The registry key does not exist."
}


