<#
.SYNOPSIS
Enable Windows Defender Credential Guard.

.DESCRIPTION
This script enables Windows Defender Credential Guard by modifying the registry settings.
The EnableVirtualizationBasedSecurity, RequirePlatformSecurityFeatures, and LsaCfgFlags registry keys are set to the specified values.

.PARAMETER None

.EXAMPLE
Enable-WindowsDefenderCredentialGuard

.NOTES

#>

$parentFolder = Split-Path -Path $MyInvocation.MyCommand.Path -Parent
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard"

if (Test-Path -Path $parentFolder) {
  $currentValues = Get-ItemProperty -Path $registryPath -ErrorAction SilentlyContinue

  if ($currentValues.EnableVirtualizationBasedSecurity -ne 1 -or
      $currentValues.RequirePlatformSecurityFeatures -ne 3 -or
      $currentValues.LsaCfgFlags -ne 1) {
    Set-ItemProperty -Path $registryPath -Name EnableVirtualizationBasedSecurity -Value 1
    Set-ItemProperty -Path $registryPath -Name RequirePlatformSecurityFeatures -Value 3
    Set-ItemProperty -Path $registryPath -Name LsaCfgFlags -Value 1

    Write-Host "[0345_Enable_Windows_Defender_Credential_Guard] Configuration applied:"
    Write-Host "EnableVirtualizationBasedSecurity = 1"
    Write-Host "RequirePlatformSecurityFeatures = 3"
    Write-Host "LsaCfgFlags = 1"
  } else {
    Write-Host "[0345_Enable_Windows_Defender_Credential_Guard] Configuration values are already set."
  }
} else {
  Write-Host "[0345_Enable_Windows_Defender_Credential_Guard] Parent folder does not exist."
}
