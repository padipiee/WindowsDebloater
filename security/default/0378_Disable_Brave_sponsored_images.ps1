
<#
.SYNOPSIS
Disables the Brave browser's sponsored images feature by modifying the registry.

.DESCRIPTION
This script disables the Brave browser's sponsored images feature by modifying the registry value of "ShowSponsoredImages" under "HKCU:\Software\BraveSoftware\Brave-Browser". If the registry value doesn't exist, it will be created and set to 0. If the value already exists and is not 0, it will be adjusted to 0. If the value is already 0, no modification will be made.

.PARAMETER path
The registry path where the value is located.

.PARAMETER propertyName
The name of the registry property to modify.

.PARAMETER value
The value to set the registry property to.

.EXAMPLE
Set-RegistryValue -Path "HKCU:\Software\BraveSoftware\Brave-Browser" -PropertyName "ShowSponsoredImages" -Value 0
#>
function Set-RegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [int]$value
    )

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue
    $title = "[0378_Disable_Brave_sponsored_images]"

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

Set-RegistryValue -Path "HKCU:\Software\BraveSoftware\Brave-Browser" -PropertyName "ShowSponsoredImages" -Value 0