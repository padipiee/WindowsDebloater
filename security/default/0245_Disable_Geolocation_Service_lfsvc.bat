::Disable_Geolocation_Service_lfsvc
::5.5 Ensure 'Geolocation Service (lfsvc)' is set to 'Disabled'
::https://www.tenable.com/audits/items/CIS_MS_Windows_11_Enterprise_Level_2_Bitlocker_Next_Generation_Windows_Security_v1.0.0.audit:6e3541085b8b7d93f5f1e86368116d40
sc config lfsvc start=disabled
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 4 /f 
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 0 /f 
sc stop lfsvc
::sc delete lfsvc