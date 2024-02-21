<#
.SYNOPSIS
Disables app access to voice activation when the device is locked.

.DESCRIPTION
This script disables the ability for apps to access voice activation when the device is locked. It checks the value of a specific registry key and updates it if necessary.

.PARAMETER registryPath
The path to the registry key that controls app access to voice activation when the device is locked.

.PARAMETER registryValueName
The name of the registry value that controls app access to voice activation when the device is locked.

.PARAMETER targetValue
The desired value for the registry key. If the current value is different from the target value, the script will update it.

.NOTES
- This script requires administrative privileges to modify the registry.
- The registry key and value names may vary depending on the Windows version.

.EXAMPLE
Disable-AppAccessToVoiceActivation -registryPath "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -registryValueName "AgentActivationOnLockScreenEnabled" -targetValue 0
#>
$registryPath = "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps"
$registryValueName = "AgentActivationOnLockScreenEnabled"
$targetValue = 0

# Check if the registry key exists
if (Test-Path $registryPath) {
  # Get the current value of the registry key
  $currentValue = Get-ItemPropertyValue -Path $registryPath -Name $registryValueName

  # Check if the current value is different from the target value
  if ($currentValue -ne $targetValue) {
    # Set the target value for the registry key
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $targetValue

    # Display a message indicating that the value has been updated
    Write-Host "[0046_Disable_App_Access_To_Voice_Activation_When_Device_Is_Locked] The value of '$registryValueName' has been updated to '$targetValue'."
  }
  else {
    # Display a message indicating that the value is already set to the target value
    Write-Host "[0046_Disable_App_Access_To_Voice_Activation_When_Device_Is_Locked] The value of '$registryValueName' is already set to '$targetValue'."
  }
}
else {
  # Display a message indicating that the registry key does not exist
  Write-Host "[0046_Disable_App_Access_To_Voice_Activation_When_Device_Is_Locked] The registry key '$registryPath' does not exist."
}
