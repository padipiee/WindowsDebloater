
::powershell Anything that is a “Get-“ call -
::MalwareArchaeology.com  WINDOWS POWERSHELL LOGGING CHEAT SHEET
::https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/wevtutil
WevtUtil qe "Microsoft-Windows-PowerShell/Operational" /q:"*[System[(EventID=4104)]]" /c:1000 /rd:true /f:text | findstr /i "Get-"