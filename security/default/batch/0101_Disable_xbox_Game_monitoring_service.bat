
:: Disable Xbox Game Monitoring Windows 10 service
:: http://batcmd.com/windows/10/services/xbgm/
:: http://batcmd.com/windows/10/services/xbgm/
:: reg query "HKLM\System\CurrentControlSet\Services\xbgm"
reg add "HKLM\System\CurrentControlSet\Services\xbgm" /v "Start" /t REG_DWORD /d "4" /f
