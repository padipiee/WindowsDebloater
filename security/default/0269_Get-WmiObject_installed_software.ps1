# Get installed software

Get-WmiObject win32_product | Select-Object Name, Caption, Description, InstallLocation, InstallSource, InstallDate, PackageName, Version


