<#
.SYNOPSIS
Activates the AllowNetworkProtectionDownLevel option for Windows Defender.

.DESCRIPTION
This script activates the AllowNetworkProtectionDownLevel option for Windows Defender, which specifies whether to allow network protection to be set to Enabled or Audit Mode on Windows versions before 1709.

.NOTES
- This script requires administrative privileges.
- The script sets the registry value to 1 to enable the option.
- The script sets the Windows Defender preference to EnableNetworkProtection Enabled and AllowNetworkProtectionDownLevel $true.

.EXAMPLE
PS C:\> .\0340_Activate_windows_defender_AllowNetworkProtectionDownLevel.ps1
Activates the AllowNetworkProtectionDownLevel option for Windows Defender.

.INPUTS
None.

.OUTPUTS
None.

#> 


# Activate AllowNetworkProtectionDownLevel option for Windows defender
## !! Specifies whether to allow network protection to be set to Enabled or Audit Mode on Windows versions before 1709. !!

# https://jeffreyappel.nl/microsoft-defender-for-endpoint-series-validate-defender-protection-and-additional-troubleshooting-part6/
# https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/network-protection?view=o365-worldwide
# https://learn.microsoft.com/en-us/windows/client-management/mdm/defender-csp#configurationallownetworkprotectiondownlevel

#This settings controls whether Network Protection is allowed to be configured into block or audit mode on windows downlevel of RS3. If false, the value of EnableNetworkProtection will be ignored.
# 1	Network protection will be enabled downlevel.
# 0 (Default)	Network protection will be disabled downlevel.


function Test-AdminPriv {
  # Check if running with administrative privileges
  if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This function requires administrative privileges. Please run PowerShell as an administrator."
    exit 1
  }
}


function Test-Get-MpPreference-AllowNetworkProtectionDownLevel { 
  # Get Windows Defender preferences
  $mpPreference = Get-MpPreference
  
  # Check if the AllowNetworkProtectionDownLevel option is enabled
  if ($mpPreference.AllowNetworkProtectionDownLevel -eq 1) {
    Write-Host "Get-MpPreference : AllowNetworkProtectionDownLevel option is currently enabled in Windows Defender."
  }
  else {
    Write-Host "Get-MpPreference : AllowNetworkProtectionDownLevel option is currently disabled in Windows Defender."
  }
}

function Set-Registry-AllowNetworkProtectionDownLevel { 
  # Set registry path and value
  $registryPath = "HKLM:\Software\Policies\Microsoft\Windows Defender\Real-Time Protection"
  $registryValue = "AllowNetworkProtectionDownLevel"
  
  try {
    # Check if the registry key exists
    if (Test-Path -Path $registryPath) {
      # Set the registry value to 1 to enable the option
      Set-ItemProperty -Path $registryPath -Name $registryValue -Value 1
      reg query "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection"
      Write-Host "Successfully activated AllowNetworkProtectionDownLevel registry option for Windows Defender."
    }
    else {
      Write-Warning "The required registry key does not exist. Please ensure that Windows Defender is installed on the system."
    }
  }
  catch {
    Write-Error "Failed to activate AllowNetworkProtectionDownLevel option in Windows Defender. Error: $_"
  }
}


function Set-MpPreference-AllowNetworkProtectionDownLevel {  
  try {
    # Set Windows Defender preference
    Set-MpPreference -EnableNetworkProtection Enabled
    Write-Host "Set-MpPreference :  EnableNetworkProtection Enabled"
    Set-MpPreference -AllowNetworkProtectionDownLevel $true
    $real_status = (Get-MpPreference).AllowNetworkProtectionDownLevel
    Write-Host "Set-MpPreference :  AllowNetworkProtectionDownLevel option was set to $real_status in Windows Defender."

  }
  catch {
    Write-Error "Set-MpPreference : Failed to set AllowNetworkProtectionDownLevel option to $true in Windows Defender. Error: $_"
  }
}

Test-AdminPriv
Test-Get-MpPreference-AllowNetworkProtectionDownLevel
Set-Registry-AllowNetworkProtectionDownLevel
Set-MpPreference-AllowNetworkProtectionDownLevel