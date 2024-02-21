<#
.SYNOPSIS
This script disables the Windows Customer Experience Improvement Program by modifying the registry.
#echo  Disable Windows Customer Experience Improvement Program 
# HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows

# This policy setting turns off the Windows Customer Experience Improvement Program
# If you enable this policy setting, all users are opted out of the Windows Customer Experience Improvement Program.

.DESCRIPTION
The function Set-RegistryValue is used to set a registry value at the specified path. If the property doesn't exist, it creates it and sets the value. If the property exists and its value is different from the specified value, it adjusts the value. If the property exists and its value is already the specified value, no modification is made.

.PARAMETER path
The registry path where the property is located.

.PARAMETER propertyName
The name of the property to be modified.

.PARAMETER value
The value to set for the property.

.PARAMETER propertyType
The type of the property. Default value is "DWORD".

.EXAMPLE
Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient" -PropertyName "CorporateSQMURL" -Value "0.0.0.0" -PropertyType "String"
#>
function Set-RegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [string]$value,
        [string]$propertyType = "DWORD"
    )

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue
    $title="[0055_Disable_windows_customer_experience_improvement_program_CorporateSQMURL]"

    if (-not $existingValue) {
        # If the property doesn't exist, create it
        New-ItemProperty -Path $path -Name $propertyName -Value $value -PropertyType $propertyType -Force
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

Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient" -PropertyName "CorporateSQMURL" -Value "0.0.0.0" -PropertyType "String"

