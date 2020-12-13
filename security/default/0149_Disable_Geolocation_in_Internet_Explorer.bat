
:: Privacy - Disable Geolocation in Internet Explorer.
reg add "HKEY_CURRENT_USER\Software\Policies\Microsoft\Internet Explorer\Geolocation" /v "PolicyDisableGeolocation" /t REG_DWORD /d 1 /f