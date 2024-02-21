<#
.SYNOPSIS
Disables app access to voice activation in Windows 10.

.DESCRIPTION
This script disables app access to voice activation by modifying the registry settings. It checks if the specified registry path and property exist, and if the current value is different from the desired value. If so, it updates the value to disable app access to voice activation.

.PARAMETER registryPath
The registry path where the property is located.

.PARAMETER propertyName
The name of the property to be modified.

.PARAMETER desiredValue
The desired value to set for the property.

.NOTES
- This script should be run with administrative privileges.
- It is recommended to create a backup of the registry before running this script.

.EXAMPLE
Disable-AppAccessToVoiceActivation -registryPath "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps" -propertyName "AgentActivationEnabled" -desiredValue 0
#>

$registryPath = "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps"
$propertyName = "AgentActivationEnabled"
$desiredValue = 0

if (!(Test-Path $registryPath)) {
    Write-Host "[0047_Disable_App_Access_To_Voice_Activation] Registry path does not exist: $registryPath"
} else {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $propertyName -ErrorAction SilentlyContinue
    if ($null -eq $currentValue) {
        Write-Host "[0047_Disable_App_Access_To_Voice_Activation] Property does not exist: $propertyName"
    } elseif ($currentValue.$propertyName -ne $desiredValue) {
        Set-ItemProperty -Path $registryPath -Name $propertyName -Value $desiredValue -Force
        Write-Host "[0047_Disable_App_Access_To_Voice_Activation] Value updated for property: $propertyName"
    } else {
        Write-Host "[0047_Disable_App_Access_To_Voice_Activation] Value is already set to $desiredValue for property: $propertyName"
    }
}
