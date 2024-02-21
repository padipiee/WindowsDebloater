# Run this script as an Administrator

<#
.SYNOPSIS
This script disables various advertising features in Windows 10/11.

.DESCRIPTION
The script uses the Set-RegistryValue function to modify registry values and disable specific advertising features. 
It sets the following registry values:
- RotatingLockScreenOverlayEnabled: Disables overlays on the lock screen.


Disable ads in Windows 10/11 - Disable Windows Consumer Features (App Suggestions on Start) 
REF 1  Powershell : 0075_Disassembler0_Win10-Initial-Setup-Script.ps1
REF 2  Batch : 0037_Disable_Windows_Consumer_Features.bat

.PARAMETER path
The registry path where the property is located.

.PARAMETER propertyName
The name of the property to be modified.

.PARAMETER value
The value to set for the property.

.EXAMPLE


.NOTES
This script should be run with administrative privileges.
#>

function Set-RegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [int]$value
    )

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue

    if (-not $existingValue) {
        # If the property doesn't exist, create it
        New-ItemProperty -Path $path -Name $propertyName -Value $value -PropertyType DWORD -Force
        Write-Host "[$propertyName] created and set to $value"
    } elseif ($existingValue.$propertyName -ne $value) {
        # If the property exists and its value is not $value, set its value
        Set-ItemProperty -Path $path -Name $propertyName -Value $value
        Write-Host "[$propertyName] adjusted to $value"
    } else {
        # If the property exists and its value is already $value
        Write-Host "[$propertyName] is already set to $value. No modification"
    }
}

# Set the values for the properties
Set-RegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -PropertyName "RotatingLockScreenEnabled" -Value 0
