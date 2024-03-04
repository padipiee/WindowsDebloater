<#
.SYNOPSIS
Disables the Brave Rewards icon in the Brave Browser.
This hides the Brave Rewards icon in the browser.

.DESCRIPTION
This script disables the Brave Rewards icon in the Brave Browser by modifying the registry value of "ShowBraveRewardsIcon" under "HKCU:\Software\BraveSoftware\Brave-Browser". If the registry value does not exist, it will be created and set to 0. If the registry value already exists and is not 0, it will be adjusted to 0. If the registry value is already set to 0, no modification will be made.

.PARAMETER path
The registry path where the property exists or will be created.

.PARAMETER propertyName
The name of the property to modify or create.

.PARAMETER value
The value to set for the property.

.EXAMPLE
Set-RegistryValue -Path "HKCU:\Software\BraveSoftware\Brave-Browser" -PropertyName "ShowBraveRewardsIcon" -Value 0
#>
function Set-RegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [int]$value
    )

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue
    $title = "[0377_Disable_Brave_rewards]"

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

Set-RegistryValue -Path "HKCU:\Software\BraveSoftware\Brave-Browser" -PropertyName "ShowBraveRewardsIcon" -Value 0
