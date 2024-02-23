# Disable Brave Rewards
# This hides the Brave Rewards icon in the browser.

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
