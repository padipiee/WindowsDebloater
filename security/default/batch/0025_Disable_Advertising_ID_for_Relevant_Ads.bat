:: Disable Advertising ID for Relevant Ads
:: Advertising ID Let Apps use for Relevant Ads in Windows 10...
:: Windows Registry Editor Version 5.00
:: [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo]
:: "Enabled"=dword:00000000
:: Enabled = 1 - the feature is enabled : you share the Ad ID...
:: Enabled = 0 - the feature is disabled.
echo Disable Advertising ID for Relevant Ads
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f 