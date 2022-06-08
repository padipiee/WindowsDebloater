:: REF 0016_Disable_global_Telemetry
echo  Disable dmwappushservice  | Disable WAP Push Message Routing Service
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d 4 /f 

sc stop dmwappushservice
sc config dmwappushservice start= disabled

::https://docs.microsoft.com/en-us/troubleshoot/windows-client/networking/network-gets-disconnected-computer-not-used-after-sign-in

::https://github.com/AdguardTeam/AdguardForWindows/issues/3655
:: 4 = deactivated

sc query dmwappushservice
