<#
.SYNOPSIS
This script disables the "Show notifications from sync provider" and "Get cool data, tips and more from Windows and Cortana on the lock screen" features in Windows 10.

.DESCRIPTION
The script modifies the registry settings to disable the specified features. It should be run as an Administrator.

#ShowSyncProviderNotifications = 0 - disables notifications.
#ShowSyncProviderNotifications = 1 - File Explorer shows ads (default)

.PARAMETER None

.EXAMPLE
.\0373_Disable_cool_data_tips_screen_log.ps1

.NOTES
Author: [Your Name]
Date: [Date]
Version: 1.0
#>
# Run this script as an Administrator

# Run this script as an Administrator

function SetRegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [int]$value
    )

    if (!(Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue)) {
        # If the property doesn't exist, create it
        New-ItemProperty -Path $path -Name $propertyName -Value $value -PropertyType DWORD -Force
        Write-Host "[0373_Disable_cool_data_tips_screen_log] $propertyName created and set to $value"
    } elseif ((Get-ItemProperty -Path $path).$propertyName -ne $value) {
        # If the property exists and its value is not $value, set its value
        Set-ItemProperty -Path $path -Name $propertyName -Value $value
        Write-Host "[0373_Disable_cool_data_tips_screen_log] $propertyName adjusted to $value"
    } else {
        # If the property exists and its value is already $value
        Write-Host "[0373_Disable_cool_data_tips_screen_log] $propertyName is already set to $value. No modification"
    }
}

# Set the values for the properties
SetRegistryValue -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -propertyName "ShowSyncProviderNotifications" -value 0
SetRegistryValue -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -propertyName "ContentDeliveryAllowed" -value 0
SetRegistryValue -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -propertyName "RotatingLockScreenOverlayEnabled" -value 0
SetRegistryValue -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -propertyName "SubscribedContent-338389Enabled" -value 0


