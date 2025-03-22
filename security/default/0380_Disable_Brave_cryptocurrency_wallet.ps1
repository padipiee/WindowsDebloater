# Disable Brave Rewards
# This hides the Brave Rewards icon in the browser.

function Set-RegistryValue {
    param(
        [string]$path,
        [string]$propertyName,
        [object]$value,
        [string]$valueType = "DWORD"
    )

    $existingValue = Get-ItemProperty -Path $path -Name $propertyName -ErrorAction SilentlyContinue
    $title = "[0380_Disable_Brave_cryptocurrency_wallet]"

    if (-not $existingValue) {
        # If the property doesn't exist, create it
        New-ItemProperty -Path $path -Name $propertyName -Value $value -PropertyType $valueType -Force
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

# Ensure registry path exists
$registryPath = "HKCU:\Software\BraveSoftware\Brave-Browser"
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "[0380_Disable_Brave_cryptocurrency_wallet] Created registry path: $registryPath"
}

# Set the value as a string with "None"
Set-RegistryValue -Path $registryPath -PropertyName "DefaultCryptocurrencyWallet" -Value "None" -ValueType "String"

