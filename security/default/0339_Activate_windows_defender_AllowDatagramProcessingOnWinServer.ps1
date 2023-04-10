# Activate AllowDatagramProcessingOnWinServer option for Windows defender
# https://jeffreyappel.nl/microsoft-defender-for-endpoint-series-validate-defender-protection-and-additional-troubleshooting-part6/
# https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/network-protection?view=o365-worldwide

function Check-AdminPriv {
  # Check if running with administrative privileges
  if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "This function requires administrative privileges. Please run PowerShell as an administrator."
    exit 1
  }
}


function Test-Get-MpPreference-AllowDatagramProcessingOnWinServer { 
  # Get Windows Defender preferences
  $mpPreference = Get-MpPreference
  
  # Check if the AllowDatagramProcessingOnWinServer option is enabled
  if ($mpPreference.AllowDatagramProcessingOnWinServer -eq 1) {
    Write-Host "Get-MpPreference : AllowDatagramProcessingOnWinServer option is currently enabled in Windows Defender."
  } else {
    Write-Host "Get-MpPreference : AllowDatagramProcessingOnWinServer option is currently disabled in Windows Defender."
  }
}

function Set-Registry-AllowDatagramProcessingOnWinServer { 
  # Set registry path and value
  $registryPath = "HKLM:\Software\Policies\Microsoft\Windows Defender\Real-Time Protection"
  $registryValue = "AllowDatagramProcessingOnWinServer"
  
  try {
    # Check if the registry key exists
    if (Test-Path -Path $registryPath) {
      # Set the registry value to 1 to enable the option
      Set-ItemProperty -Path $registryPath -Name $registryValue -Value 1
      reg query "HKLM\Software\Policies\Microsoft\Windows Defender\Real-Time Protection"
      Write-Host "Successfully activated AllowDatagramProcessingOnWinServer registry option for Windows Defender."
    } else {
      Write-Warning "The required registry key does not exist. Please ensure that Windows Defender is installed on the system."
    }
  } catch {
    Write-Error "Failed to activate AllowDatagramProcessingOnWinServer option in Windows Defender. Error: $_"
  }
}


function Set-MpPreference-AllowDatagramProcessingOnWinServer {  
  try {
    # Set Windows Defender preference
    Set-MpPreference -EnableNetworkProtection Enabled
    Write-Host "Set-MpPreference :  EnableNetworkProtection Enabled"
    Set-MpPreference -AllowDatagramProcessingOnWinServer $true
    $real_status = (Get-MpPreference).AllowDatagramProcessingOnWinServer
    Write-Host "Set-MpPreference :  AllowDatagramProcessingOnWinServer option set to $real_status in Windows Defender."

  } catch {
    Write-Error "Set-MpPreference : Failed to set AllowDatagramProcessingOnWinServer option to $true in Windows Defender. Error: $_"
  }
}

Check-AdminPriv
Test-Get-MpPreference-AllowDatagramProcessingOnWinServer
Set-Registry-AllowDatagramProcessingOnWinServer
Set-MpPreference-AllowDatagramProcessingOnWinServer