<#
.SYNOPSIS
Enforce screen locking. Enables the lock computer after inactivity policy by setting the InactivityTimeoutSecs registry key.
# Set screen saver inactivity timeout to 15 minutes
# reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v InactivityTimeoutSecs /t REG_DWORD /d 900 /f

.DESCRIPTION
This script checks if the "InactivityTimeoutSecs" registry key exists under "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System".
If the key exists, it updates the value to 900 seconds (15 minutes). If the key does not exist, it creates the key and sets the value to 900 seconds.
This ensures that the computer will lock after 15 minutes of inactivity.

# https://www.stigviewer.com/stig/windows_server_20122012_r2_domain_controller/2017-06-09/finding/V-36773
# https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/interactive-logon-machine-inactivity-limit
#  https://www.tenforums.com/tutorials/118314-automatically-lock-computer-when-idle-specified-time-windows-10-a.html
#  https://www.kapilarya.com/how-to-automatically-lock-computer-after-inactivity-in-windows-11

.PARAMETERS
None.

.EXAMPLE
.\0414_Enable_lock_computer_after_inactivity.ps1
This example runs the script to enable the lock computer after inactivity policy.

.NOTES
Author: [Your Name]
Date: [Date]
#>

# Check if the registry key exists
if (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System") {
    $currentValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "InactivityTimeoutSecs" -ErrorAction SilentlyContinue
    if ($null -eq $currentValue) {
        New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "InactivityTimeoutSecs" -Value 900 -PropertyType DWord -Force
        Write-Host "InactivityTimeoutSecs set to 900 (created)."
    } elseif ($currentValue.InactivityTimeoutSecs -ne 900) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "InactivityTimeoutSecs" -Value 900
        Write-Host "InactivityTimeoutSecs set to 900 (updated)."
    } else {
        Write-Host "InactivityTimeoutSecs is already 900."
    }
} else {
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Force | Out-Null
    New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "InactivityTimeoutSecs" -Value 900 -PropertyType DWord -Force
    Write-Host "InactivityTimeoutSecs set to 900 (path created)."
}

# @REM #Interactive logon: Machine inactivity limit'
# @REM $indextest += 1
# @REM $chaine = $null
# @REM $traitement = $null
# @REM $exist = $null
# @REM $id = "IL" + "$indextest"
# @REM $chaine = "$id" + ";" + "(L1)Ensure Interactive logon: Machine inactivity limit' is set to 900 or fewer second(s), but not 0 " + ";"
# @REM $exist = Test-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
# @REM if ( $exist -eq $true) {
# @REM  $traitement = Get-ItemProperty HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System |Select-Object InactivityTimeoutSecs
# @REM  $traitement = $traitement.InactivityTimeoutSecs
# @REM }
# @REM else {
# @REM  $traitement = "not configure"
# @REM }

# @REM ;;; 2.3.7.4 (L1) Ensure 'Interactive logon: Machine inactivity limit' is set to '900 or fewer second(s), but not 0'
# @REM [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System]
# @REM ; <deleted> = (Default)
# @REM ; 0000000 = Off
# @REM ; 0000384 = 900 seconds, 15 minutes (CIS)
# @REM "InactivityTimeoutSecs"=dword:0000384

# # https://www.stigviewer.com/stig/windows_10/2016-06-24/finding/V-63669
# - name: Configure machine inactivity limit and after locking the system with the screensaver.
#   win_regedit:
#     key: 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
#     value: InactivityTimeoutSecs
#     datatype: dword
#     data: "{{ harden_win_InactivityTimeoutSecs | default(900) }}"