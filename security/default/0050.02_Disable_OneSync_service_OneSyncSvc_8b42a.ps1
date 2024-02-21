<#
.SYNOPSIS
Disables the OneSync Sync Host service.

.DESCRIPTION
This script disables the OneSync Sync Host service by modifying the registry values of the corresponding service keys.

.PARAMETER path
The registry path of the service key.

.PARAMETER propertyName
The name of the property to be modified.

.PARAMETER value
The value to set for the property.

.EXAMPLE
Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\OneSyncSvc" -PropertyName "Start" -Value 4

This example sets the "Start" property of the "OneSyncSvc" service key to 4, disabling the service.

.NOTES
This script requires administrative privileges to modify the registry.
#>

function Set-RegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [int]$value
    )

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue
    $title="[0050.02_Disable_OneSync_service_OneSyncSvc_8b42a]"

    if (-not $existingValue) {
        # If the property doesn't exist, create it
        New-ItemProperty -Path $path -Name $propertyName -Value $value -PropertyType DWORD -Force
        Write-Host "$title [$propertyName] created and set to $value"
    } elseif ($existingValue.$propertyName -ne $value) {
        # If the property exists and its value is not $value, set its value
        Set-ItemProperty -Path $path -Name $propertyName -Value $value
        Write-Host "$title [$propertyName] adjusted to $value"
    } else {
        # If the property exists and its value is already $value
        Write-Host "$title [$propertyName] is already set to $value. No modification"
    }
}

# Disable OneSync Sync Host service
Set-RegistryValue -Path "HKLM:\SYSTEM\CurrentControlSet\Services\OneSyncSvc_8b42a" -PropertyName "Start" -Value 4