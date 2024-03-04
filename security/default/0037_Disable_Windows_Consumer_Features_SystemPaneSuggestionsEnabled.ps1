<#
.SYNOPSIS
Disables the Windows Consumer Features System Pane Suggestions.

.DESCRIPTION
This script disables the System Pane Suggestions feature in the Windows Consumer Features settings. It checks the registry path and value, and updates it if necessary.

.PARAMETER None

.EXAMPLE
Disable-WindowsConsumerFeaturesSystemPaneSuggestions

.NOTES
Author: [Your Name]
Date: [Current Date]
#>

$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
$registryValueName = "SystemPaneSuggestionsEnabled"
$targetValue = 0

if (Test-Path $registryPath) {
  $currentValue = Get-ItemProperty -Path $registryPath -Name $registryValueName | Select-Object -ExpandProperty $registryValueName

  if ($currentValue -ne $targetValue) {
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $targetValue
    Write-Host "[0037_Disable_Windows_Consumer_Features_SystemPaneSuggestionsEnabled] Value for $registryPath $registryValueName updated to $targetValue"
  }
  else {
    Write-Host "[0037_Disable_Windows_Consumer_Features_SystemPaneSuggestionsEnabled] Value for $registryPath $registryValueName  is already set to $targetValue"
  }
}
else {
  Write-Host "[0037_Disable_Windows_Consumer_Features_SystemPaneSuggestionsEnabled] Registry path $registryPath does not exist"
}
