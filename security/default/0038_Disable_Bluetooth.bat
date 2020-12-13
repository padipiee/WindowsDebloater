echo Disable Bluetooth 

:: change the value of Type DWORD from 0 to 1 to deactivate Bluetooth
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\ActionCenter\Quick Actions\All\SystemSettings_Device_BluetoothQuickAction" /v "Type" /t REG_DWORD /d "1" /f