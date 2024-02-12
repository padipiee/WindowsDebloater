<#
.SYNOPSIS
Disables Windows tips and soft landing feature.

.DESCRIPTION
This script disables the Windows tips and soft landing feature by modifying the registry value.
If the registry path exists and the current value is already set to the target value, it displays a message indicating that the value is already set.
Otherwise, it sets the registry value to the target value and displays a message indicating the change.

.PARAMETER registryPath
The registry path where the value is located.

.PARAMETER registryValueName
The name of the registry value to modify.

.PARAMETER targetValue
The value to set the registry value to.

.NOTES
Author: [Your Name]
Date: [Current Date]
Version: 1.0
#>
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$registryValueName = "DisableSoftLanding"
$targetValue = 1

if (Test-Path $registryPath) {
    $currentValue = Get-ItemProperty -Path $registryPath -Name $registryValueName -ErrorAction SilentlyContinue
    if ($currentValue -and $currentValue.$registryValueName -eq $targetValue) {
        Write-Host "[0079_Disable_Windows_tips_DisableSoftLanding] The registry value '$registryValueName' is already set to the target value '$targetValue'."
    }
    else {
        Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $targetValue -Force
        Write-Host "[0079_Disable_Windows_tips_DisableSoftLanding] The registry value '$registryValueName' has been set to the target value '$targetValue'."
    }
}
else {
    Write-Host "[0079_Disable_Windows_tips_DisableSoftLanding] The registry path '$registryPath' does not exist."
}


