<#
.SYNOPSIS
Disables anonymous enumeration in Windows security settings.

.DESCRIPTION
This script disables anonymous enumeration by modifying the registry value of "restrictanonymous" under the "HKLM:\system\currentcontrolset\control\lsa" registry path. If the registry key does not exist, a message will be displayed.

.PARAMETER registryPath
The registry path where the "restrictanonymous" value is located.

.PARAMETER registryValueName
The name of the registry value to be modified.

.PARAMETER targetValue
The desired value to set for the registry value.

.NOTES
- This script requires administrative privileges to modify the registry.
- It is recommended to run this script on Windows 10 or later.

.EXAMPLE
Disable-AnonymousEnumeration -registryPath "HKLM:\system\currentcontrolset\control\lsa" -registryValueName "restrictanonymous" -targetValue 2
#>
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
    Write-Host "[0040_Disable_anonymous_enumeration_restrictanonymous] The value of $registryPath  $registryValueName has been updated to $targetValue"
  }
  else {
    # Display a message indicating that the value is already set to the target value
    Write-Host "[0040_Disable_anonymous_enumeration_restrictanonymous] The value of $registryPath  $registryValueName is already set to $targetValue"
  }
}
else {
  # Display a message indicating that the registry key does not exist
  Write-Host "[0040_Disable_anonymous_enumeration_restrictanonymous] The registry key $registryPath does not exist"
}
