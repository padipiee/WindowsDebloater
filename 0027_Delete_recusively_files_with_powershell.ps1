# Useful command to Delete  recusively files with powershell. 
# Adapt path and filter accordingly


Get-ChildItem -path E:\SCANS -Include *.part -Recurse | Remove-Item -Verbose