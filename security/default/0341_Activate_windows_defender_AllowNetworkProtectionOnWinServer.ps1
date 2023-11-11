<#
.SYNOPSIS
Activates the AllowNetworkProtectionOnWinServer option for Windows Defender.

.DESCRIPTION
This script activates the AllowNetworkProtectionOnWinServer option for Windows Defender. It checks if the option is already enabled, and if not, it sets the required registry key and Windows Defender preference to enable it.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
.\0341_Activate_windows_defender_AllowNetworkProtectionOnWinServer.ps1
Activates the AllowNetworkProtectionOnWinServer option for Windows Defender.

.NOTES
Author: Unknown
Date: Unknown
#>
# Activate AllowNetworkProtectionOnWinServer option for Windows defender
# https://jeffreyappel.nl/microsoft-defender-for-endpoint-series-validate-defender-protection-and-additional-troubleshooting-part6/
# https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/network-protection?view=o365-worldwide
# https://learn.microsoft.com/en-us/windows/client-management/mdm/defender-csp#configurationallownetworkprotectiondownlevel




function Test-AdminPriv {
  # Check if running with administrative privileges
  if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This function requires administrative privileges. Please run PowerShell as an administrator."
    exit 1
  }
}


function Test-Get-MpPreference-AllowNetworkProtectionOnWinServer { 
  # Get Windows Defender preferences
  $mpPreference = Get-MpPreference
  
  # Check if the AllowNetworkProtectionOnWinServer option is enabled
  if ($mpPreference.AllowNetworkProtectionOnWinServer -eq 1) {
    Write-Host "Get-MpPreference : AllowNetworkProtectionOnWinServer option is currently enabled in Windows Defender."
  } else {
    Write-Host "Get-MpPreference : AllowNetworkProtectionOnWinServer option is currently disabled in Windows Defender."
  }
}

function Set-Registry-AllowNetworkProtectionOnWinServer { 
  # Set registry path and value
  $registryPath = "HKLM:\Software\Policies\Microsoft\Windows Defender\Real-Time Protection"
  $registryValue = "AllowNetworkProtectionOnWinServer"
  
  try {
    # Check if the registry key exists
    if (Test-Path -Path $registryPath) {
      # Set the registry value to 1 to enable the option
      Set-ItemProperty -Path $registryPath -Name $registryValue -Value 1
      reg query "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection"
      Write-Host "Successfully activated AllowNetworkProtectionOnWinServer registry option for Windows Defender."
    } else {
      Write-Warning "The required registry key does not exist. Please ensure that Windows Defender is installed on the system."
    }
  } catch {
    Write-Error "Failed to activate AllowNetworkProtectionOnWinServer option in Windows Defender. Error: $_"
  }
}


function Set-MpPreference-AllowNetworkProtectionOnWinServer {  
  try {
    # Set Windows Defender preference
    Set-MpPreference -EnableNetworkProtection Enabled
    Write-Host "Set-MpPreference :  EnableNetworkProtection Enabled"
    Set-MpPreference -AllowNetworkProtectionOnWinServer $true
    $real_status = (Get-MpPreference).AllowNetworkProtectionOnWinServer
    Write-Host "Set-MpPreference :  AllowNetworkProtectionOnWinServer option was set to $real_status in Windows Defender."

  } catch {
    Write-Error "Set-MpPreference : Failed to set AllowNetworkProtectionOnWinServer option to $true in Windows Defender. Error: $_"
  }
}

Test-AdminPriv
Test-Get-MpPreference-AllowNetworkProtectionOnWinServer
Set-Registry-AllowNetworkProtectionOnWinServer
Set-MpPreference-AllowNetworkProtectionOnWinServer