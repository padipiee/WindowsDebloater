$registryPath = "HKLM:\system\currentcontrolset\control\lsa"
$registryValueName = "restrictanonymous"
$targetValue = 2

# Check if the registry key exists
if (Test-Path $registryPath) {
  # Get the current value of the registry key
  $currentValue = Get-ItemProperty -Path $registryPath -Name $registryValueName | Select-Object -ExpandProperty $registryValueName

  # Check if the current value is different from the target value
  if ($currentValue -ne $targetValue) {
    # Set the registry value to the target value
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $targetValue

    # Display a message indicating that the value has been updated
    Write-Host "[0040_Disable_anonymous_enumeration] The value of $registryPath  $registryValueName has been updated to $targetValue"
  }
  else {
    # Display a message indicating that the value is already set to the target value
    Write-Host "[0040_Disable_anonymous_enumeration] The value of $registryPath  $registryValueName is already set to $targetValue"
  }
}
else {
  # Display a message indicating that the registry key does not exist
  Write-Host "[0040_Disable_anonymous_enumeration] The registry key $registryPath does not exist"
}
