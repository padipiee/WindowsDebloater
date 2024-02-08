
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
