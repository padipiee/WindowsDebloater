<#
.SYNOPSIS
Enables Windows Defender Credential Guard.

.DESCRIPTION
This script enables Windows Defender Credential Guard by setting the registry values for EnableVirtualizationBasedSecurity and LsaCfgFlags.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
.\0344_Enable_Windows_Defender_Credential_Guard.ps1

.NOTES
Ref: https://learn.microsoft.com/en-us/windows/security/identity-protection/credential-guard/credential-guard-manage
#>
## Enable Windows Defender Credential Guard
### ref 0227_Enable_vitualization_based_Security.bat
### https://learn.microsoft.com/en-us/windows/security/identity-protection/credential-guard/credential-guard-manage



$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$registryValueName = "LsaCfgFlags"
$desiredValue = 1  # Set the desired value: 1 for enabling with UEFI lock, 2 for enabling without lock, 0 for disabling

# Check if the registry path exists
if (-not (Test-Path $registryPath)) {
    # Create the registry path if it does not exist
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "[0344.02_Enable_Windows_Defender_Credential_Guard_LsaCfgFlags] Registry path did not exist and has been created."
}

# Check if the registry value exists and get its current value; if it does not exist, $currentValue will be $null
$currentValue = Get-ItemPropertyValue -Path $registryPath -Name $registryValueName -ErrorAction SilentlyContinue

if ($currentValue -ne $desiredValue) {
    # Set the registry value to the desired setting, creating the value if it does not exist
    Set-ItemProperty -Path $registryPath -Name $registryValueName -Value $desiredValue -Force
    Write-Host "[0344.02_Enable_Windows_Defender_Credential_Guard_LsaCfgFlags] Windows Defender Credential Guard setting has been applied : $registryValueName -Value $desiredValue"
} else {
    Write-Host "[0344.02_Enable_Windows_Defender_Credential_Guard_LsaCfgFlags] Windows Defender Credential Guard is already set to the desired setting $registryValueName -Value $desiredValue."
}






