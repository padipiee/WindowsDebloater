:: Turn On or Off Microsoft Defender SmartScreen for Microsoft Store Apps in Windows 10

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 1 /f 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 1 /f 

::https://www.tenforums.com/tutorials/81139-turn-off-smartscreen-microsoft-store-apps-windows-10-a.html