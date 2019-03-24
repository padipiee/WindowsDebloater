echo Disable Advertising ID for Relevant Ads
REM Advertising ID Let Apps use for Relevant Ads in Windows 10...
REM Windows Registry Editor Version 5.00
REM [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo]
REM "Enabled"=dword:00000000
REM Enabled = 1 - the feature is enabled : you share the Ad ID...
REM Enabled = 0 - the feature is disabled.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f 