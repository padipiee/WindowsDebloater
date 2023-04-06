echo  Disable Inventory Collector 
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 1 /f 
reg query "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" 
