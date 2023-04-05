# Get services

Get-WmiObject win32_service | Select-Object Name, DisplayName, State, StartName, StartMode, PathName 


