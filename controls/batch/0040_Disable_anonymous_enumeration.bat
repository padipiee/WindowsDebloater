echo | set /p=Disable Bluetooth 

REM change the value of Type DWORD from 0 to 1 to deactivate Bluetooth
REM https://social.technet.microsoft.com/Forums/en-US/52cc99bf-c810-4f4b-a741-ffb701c9c1a4/is-there-any-impact-by-enabling-restrict-anonymous-in-domain-controller?forum=winserverDS
REM 2 : Anonymous users have no access without explicit anonymous permissions.
reg add "HKLM\system\currentcontrolset\control\lsa\restrictanonymous" /v "Type" /t REG_DWORD /d "2" /f