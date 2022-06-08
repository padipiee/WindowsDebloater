#CVE-2021-34527
#Print Nightmare
#Windows Print Spooler Remote Code Execution Vulnerability
#https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-34527

Get-Service -Name Spooler
#
#Status   Name               DisplayName
#------   ----               -----------
#Running  Spooler            Print Spooler

Stop-Service -Name Spooler -Force
Set-Service -Name Spooler -StartupType Disabled
#Start-Service -Name Spooler -Force


#In addition to installing the updates, in order to secure your system, 
#you must confirm that the following registry settings are set to 0 (zero) or are not defined 
#(Note: These registry keys do not exist by default, and therefore are already at the secure setting.), 
#also that your Group Policy setting are correct (see FAQ):

#HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint
#NoWarningNoElevationOnInstall = 0 (DWORD) or not defined (default setting)
#UpdatePromptSettings = 0 (DWORD) or not defined (default setting)

#Having NoWarningNoElevationOnInstall set to 1 makes your system vulnerable by design.