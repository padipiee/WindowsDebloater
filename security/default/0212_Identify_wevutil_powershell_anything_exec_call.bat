:: Identify anything that is invoke execution call  "iex"

WevtUtil qe "Microsoft-Windows-PowerShell/Operational" /q:"*[System[(EventID=4104)]]" /c:1000 /rd:true /f:text | findstr /i "iex"

::MalwareArchaeology.com  WINDOWS POWERSHELL LOGGING CHEAT SHEET