<#
To check the status of LSAAnonymousNameLookup using PowerShell, you need to query the corresponding registry key.
This script restricts anonymous access to the SAM database to enhance security.
#>

$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$name = "RestrictAnonymousSAM"
$value = 1

# Check if the registry key exists and get its current value
try {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $name -ErrorAction Stop | Select-Object -ExpandProperty $name
    
    if ($currentValue -eq $value) {
        Write-Host "Registry value is already set to the desired value ($value). No change needed."
    } else {
        Write-Host "Updating registry value from $currentValue to $value..."
        Set-ItemProperty -Path $registryPath -Name $name -Value $value -Type DWord
        Write-Host "Registry value updated successfully."
    }
} catch {
    # If the key doesn't exist, create it
    Write-Host "Registry key not found. Creating new registry entry..."
    New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null
    Write-Host "Registry value created successfully."
}

# Verify the change
$verifyValue = Get-ItemProperty -Path $registryPath -Name $name | Select-Object -ExpandProperty $name
Write-Host "Current registry value: $verifyValue"