
<#
.SYNOPSIS
Disables NetBIOS by modifying the registry.

.DESCRIPTION
This script disables NetBIOS by modifying the registry value of the NetBIOS service.

.PARAMETER registryPath
The registry path of the NetBIOS service.

.PARAMETER propertyName
The name of the property to modify.

.PARAMETER desiredValue
The desired value to set for the property.

.NOTES
- This script requires administrative privileges to modify the registry.
- It checks if the registry path exists and if the current value of the property matches the desired value.
- If the current value does not match the desired value, it updates the registry value.
- If the current value already matches the desired value, it does not make any changes.

.EXAMPLE
Disable-NetBIOS -registryPath "HKLM:\SYSTEM\CurrentControlSet\Services\NetBIOS" -propertyName "Start" -desiredValue 4
#>

$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBIOS"
$propertyName = "Start"
$desiredValue = 4

# Check if the registry path exists
if (Test-Path $registryPath) {
    # Get the current value of the property
    $currentValue = Get-ItemProperty -Path $registryPath -Name $propertyName | Select-Object -ExpandProperty $propertyName

    # Check if the current value matches the desired value
    if ($currentValue -ne $desiredValue) {
        # Set the desired value
        Set-ItemProperty -Path $registryPath -Name $propertyName -Value $desiredValue -Force
        Write-Host "[0049_Disable_Netbios] Registry $registryPath value $propertyName updated to $desiredValue."
    } else {
        Write-Host "[0049_Disable_Netbios] Registry value  $propertyName is already set to the desired value $desiredValue."
    }
} else {
    Write-Host "[0049_Disable_Netbios] Registry path $registryPath  does not exist."
}
