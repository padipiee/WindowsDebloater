# Get CVE_2013_3900_mitigation_status

<#
.SYNOPSIS
    Creates two registry entries to mitigate WinVerifyTrust Signature Validation Vulnerability CVE-2013-3900
.DESCRIPTION
    This script creates the two necessary registry entries to mitigate WinVerifyTrust Signature Validation Vulnerability CVE-2013-3900 
    https://msrc.microsoft.com/update-guide/vulnerability/CVE-2013-3900    
  #https://github.com/tpn/winddk-8.1/blob/master/Include/um/WinTrust.h
#https://www-bleepingcomputer-com.cdn.ampproject.org/c/s/www.bleepingcomputer.com/news/microsoft/10-year-old-windows-bug-with-opt-in-fix-exploited-in-3cx-attack/amp/
#https://github.com/Mr-Un1k0d3r/ATP-PowerShell-Scripts/blob/main/211ef051-ecf9-4b99-9eed-76e45a831a19.ps1
#>



$RegentryName = "EnableCertPaddingCheck"
$path1 = "HKLM:\SOFTWARE\Microsoft\Cryptography"
$path2 = "$path1\Wintrust"
$32bitpath = "$path2\Config"
$path3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Cryptography"
$path4 = "$path3\Wintrust"
$64bitpath = "$path4\Config"

function Check-MitigationStatus { 
  $cve_2013_3900_regKey32bit = Get-ItemProperty -Path $32bitpath -Name $RegentryName
  $cve_2013_3900_regKey64bit = Get-ItemProperty -Path $64bitpath -Name $RegentryName -ErrorAction SilentlyContinue
  $cve_2013_3900_32bitMitigated = ($cve_2013_3900_regKey32bit.EnableCertPaddingCheck -eq 1)
  $cve_2013_3900_64bitMitigated = ![Environment]::Is64BitOperatingSystem -or ($cve_2013_3900_regKey64bit.EnableCertPaddingCheck -eq 1)
  
  if ($cve_2013_3900_32bitMitigated) {
    Write-Output "32 bits : $32bitpath  CVE_2013_3900_mitigation_status : Mitigated"
  }
  
  if ($cve_2013_3900_64bitMitigated) {
    Write-Output "64 bits : $64bitpath  CVE_2013_3900_mitigation_status : Mitigated"
  }
  
  if ($cve_2013_3900_32bitMitigated -and $cve_2013_3900_64bitMitigated) {
    Write-Output "ALL 32 bits and 64 bits : CVE_2013_3900_mitigation_status : Mitigated"
  } else {
    Write-Output "ALL 32 bits and 64 bits : CVE_2013_3900_mitigation_status : NOT Mitigated"
    
    Write-Output "Mitigating CVE_2013_3900..."
    New-Item -Path $path1 -Name "Wintrust" -Force
    New-Item -Path $path2 -Name "Config" -Force
    New-Item -Path $path3 -Name "Wintrust" -Force
    New-Item -Path $path4 -Name "Config" -Force
    New-ItemProperty -Path $32bitpath -Name $RegentryName -Value "1"
    New-ItemProperty -Path $64bitpath -Name $RegentryName -Value "1"
    
    if ($cve_2013_3900_32bitMitigated) {
      Write-Output "32 bits : $32bitpath  CVE_2013_3900_mitigation_status : Mitigated"
    }  
    
    if ($cve_2013_3900_64bitMitigated) {
      Write-Output "64 bits : $64bitpath  CVE_2013_3900_mitigation_status : Mitigated"
    }
    
  }
}


# Check and Mitigate
Check-MitigationStatus


