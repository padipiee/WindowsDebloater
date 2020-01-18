
REM Disable ads in Windows 10 - Disable Windows Consumer Features (App Suggestions on Start) 
REM ##REF 1  Powershell : 0075_Disassembler0_Win10-Initial-Setup-Script.ps1
REM ##REF 2  Batch : 0037_Disable_Windows_Consumer_Features.bat

REM [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced] "ShowSyncProviderNotifications"=dword:00000000
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f 


