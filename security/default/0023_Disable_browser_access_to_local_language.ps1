<#
.SYNOPSIS
Disables browser access to local language in Windows.

.DESCRIPTION
This script disables the browser's access to the local language list in Windows 10. It modifies the "HttpAcceptLanguageOptOut" registry value under "HKCU:\Control Panel\International\User Profile" to set it to 1.

.PARAMETER None

.EXAMPLE
Disable-BrowserAccessToLocalLanguage

.NOTES
Author: Unknown
Date: Unknown
Version: 1.0
#>
#echo Disable browser access to local language 
#https://www.tenforums.com/tutorials/82980-turn-off-website-access-language-list-windows-10-a.html


$registryPath = "HKCU:\Control Panel\International\User Profile"
$targetValue = 1

if (Test-Path $registryPath) {
  $currentValue = Get-ItemProperty -Path $registryPath -Name "HttpAcceptLanguageOptOut" -ErrorAction SilentlyContinue
  if ($null -eq $currentValue) {
    Write-Host "[0023_Disable_browser_access_to_local_language] Parameter does not exist in the registry."
  }
  else {
    Write-Host "[0023_Disable_browser_access_to_local_language] Current value: $($currentValue.HttpAcceptLanguageOptOut)"
    if ($currentValue.HttpAcceptLanguageOptOut -ne $targetValue) {
      Set-ItemProperty -Path $registryPath -Name "HttpAcceptLanguageOptOut" -Value $targetValue -Type DWORD -Force
      Write-Host "[0023_Disable_browser_access_to_local_language] Value updated to $targetValue."
    }
    else {
      Write-Host "[0023_Disable_browser_access_to_local_language] Value is already set to the target value $targetValue ."
    }
  }
}
else {
  Write-Host "[0023_Disable_browser_access_to_local_language] Registry path does not exist."
}


