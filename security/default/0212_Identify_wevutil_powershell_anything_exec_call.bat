::Anything that is an “iex“ (invoke execution) call - 
::MalwareArchaeology.com  WINDOWS POWERSHELL LOGGING CHEAT SHEET
WevtUtil qe "Microsoft-Windows-PowerShell/Operational" /q:"*[System[(EventID=4104)]]" /c:1000 /rd:true /f:text | findstr /i "iex"