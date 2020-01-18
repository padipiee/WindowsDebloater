:: Disable Bluetooth 
:: Change the value of Type DWORD from 0 to 1 to deactivate Bluetooth
:: https://social.technet.microsoft.com/Forums/en-US/52cc99bf-c810-4f4b-a741-ffb701c9c1a4/is-there-any-impact-by-enabling-restrict-anonymous-in-domain-controller?forum=winserverDS
:: 2 : Anonymous users have no access without explicit anonymous permissions.
:: Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa
echo Disable Bluetooth anonymous enumeration without permissions
reg add "HKLM\system\currentcontrolset\control\lsa" /v "restrictanonymous" /t REG_DWORD /d "2" /f
