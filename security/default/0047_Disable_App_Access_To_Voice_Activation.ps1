$registryPath = "HKCU:\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps"
$propertyName = "AgentActivationEnabled"
$desiredValue = 0

if (!(Test-Path $registryPath)) {
    Write-Host "[0047_Disable_App_Access_To_Voice_Activation] Registry path does not exist: $registryPath"
} else {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $propertyName -ErrorAction SilentlyContinue
    if ($currentValue -eq $null) {
        Write-Host "[0047_Disable_App_Access_To_Voice_Activation] Property does not exist: $propertyName"
    } elseif ($currentValue.$propertyName -ne $desiredValue) {
        Set-ItemProperty -Path $registryPath -Name $propertyName -Value $desiredValue -Force
        Write-Host "[0047_Disable_App_Access_To_Voice_Activation] Value updated for property: $propertyName"
    } else {
        Write-Host "[0047_Disable_App_Access_To_Voice_Activation] Value is already set to $desiredValue for property: $propertyName"
    }
}
