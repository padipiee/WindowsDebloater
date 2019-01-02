# Delete recusively files with powershell

Get-ChildItem -path E:\SCANS -Include *.part -Recurse | Remove-Item -Verbose