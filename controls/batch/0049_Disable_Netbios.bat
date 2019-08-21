echo Disable Netbios protocol
REM https://www.hardenwindows10forsecurity.com/
REM : NetBIOS over TCP/IP is not required because NetBIOS is already active without this option. 
REM Disabling NetBIOS over TCP/IP should limit NetBIOS traffic to the local subnet.
REM : The Discovery protocols are used to provide a nice graphical map of your network. For home users, this is not needed, as there is only one router.
REM HKEY_LOCAL_MACHINE
reg add "HKLM\SYSTEM\CurrentControlSet\Services\NetBIOS" /v "Start" /t REG_DWORD /d 4 /f 