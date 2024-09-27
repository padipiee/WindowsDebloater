
::To check the status of LSAAnonymousNameLookup using PowerShell, you need to query the corresponding registry key. The LSAAnonymousNameLookup 

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RestrictAnonymousSAM /t REG_DWORD /d 1 /f