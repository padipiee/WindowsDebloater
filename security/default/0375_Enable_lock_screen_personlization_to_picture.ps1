<#
.SYNOPSIS
Enables lock screen personalization to use a picture.
Avoid Windows spotlight ads when the lock screen is displayed (which is the default setting).

.DESCRIPTION
This script enables the lock screen personalization feature in Windows 11, allowing users to set a custom picture as their lock screen background.

.PARAMETER path
The registry path where the lock screen settings are stored.

.PARAMETER propertyName
The name of the property to be modified or created.

.PARAMETER value
The value to be set for the specified property.

.EXAMPLE
SetRegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lock Screen" -PropertyName "LockScreenOptions" -Value 1
#>
function SetRegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [int]$value
    )

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue

    if (-not $existingValue) {
        # If the property doesn't exist, create it
        New-ItemProperty -Path $path -Name $propertyName -Value $value -PropertyType DWORD -Force
        Write-Host "[0375_Enable_lock_screen_personlization_to_picture] $propertyName created and set to $value"
    } elseif ($existingValue.$propertyName -ne $value) {
        # If the property exists and its value is not $value, set its value
        Set-ItemProperty -Path $path -Name $propertyName -Value $value
        Write-Host "[0375_Enable_lock_screen_personlization_to_picture] $propertyName adjusted to $value"
    } else {
        # If the property exists and its value is already $value
        Write-Host "[0375_Enable_lock_screen_personlization_to_picture] $propertyName is already set to $value. No modification"
    }
}

# Set the lock screen to use a picture
SetRegistryValue -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Lock Screen" -PropertyName "LockScreenOptions" -Value 1
