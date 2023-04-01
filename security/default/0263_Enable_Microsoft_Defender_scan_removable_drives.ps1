## gets preferences for the Windows Defender scans and updates
#(Enable)
#HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan
#DisableRemovableDriveScanning DWORD
#0 or (delete) = enable scan
#1 = disable scan

Set-MpPreference -DisableRemovableDriveScanning 0
Get-MpPreference 

