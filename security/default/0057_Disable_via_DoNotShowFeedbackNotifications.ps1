$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
$registryValueName = "DoNotShowFeedbackNotifications"
$targetValue = 1

# Check if the registry key exists
if (Test-Path $registryPath) {
  # Get the current value of the registry key
  $currentValue = Get-ItemProperty -Path $registryPath -Name $registryValueName | Select-Object -ExpandProperty $registryValueName

  # Check if the current value is different from the target value
  if ($currentValue -ne $targetValue) {
    # Set the target value for the registry key
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $targetValue

    # Display a message indicating that the value has been updated
    Write-Host "[0057_Disable_via_DoNotShowFeedbackNotifications] The value for $registryPath $registryValueName has been updated to $targetValue"
  } else {
    # Display a message indicating that the value is already set to the target value
    Write-Host "[0057_Disable_via_DoNotShowFeedbackNotifications] The value for $registryPath $registryValueName is already set to $targetValue"
  }
} else {
  # Display a message indicating that the registry key does not exist
  Write-Host "[0057_Disable_via_DoNotShowFeedbackNotifications] The registry key $registryPath does not exist"
}
