
:: disable Data Collection Steps-Recorder
:: http://forum.uifserver.net/index.php?topic=145283.0

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Steps-Recorder" /v "Enabled" /t REG_DWORD /d 0 /f



