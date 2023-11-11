<#
.SYNOPSIS
This script retrieves service binary path names, service names, binary path names from service names, 
and BINARY_PATH_NAME from services and saves them to respective files.

.DESCRIPTION
This script uses WMI and Get-Service cmdlet to retrieve service binary path names, service names, binary path names from service names, and BINARY_PATH_NAME from services and saves them to respective files.
Retrives  the list of all services on the Windows system that are not located in the "system32" directory,

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
.\0337_Get_weak_permissions.ps1
This command runs the script and retrieves service binary path names, service names, binary path names from service names, and BINARY_PATH_NAME from services and saves them to respective files.

.NOTES
Author: 
Date: 
Version:
#>
# Remove existing files
Remove-Item -Path "C:\Windows\Temp\permissions.txt" -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\Servicenames.txt" -ErrorAction SilentlyContinue

# Retrieve service binary path names and save to permissions.txt
$services = Get-WmiObject -Class Win32_Service | Where-Object { $_.PathName -notmatch ".*system32.*" }
$services | ForEach-Object {
  $binaryPath = $_.PathName -replace "=", "'"
  $serviceName = $_.Name
  $binaryPath | Out-File -FilePath "C:\Windows\Temp\permissions.txt" -Append
  Write-Host "Added binary path: $binaryPath for service: $serviceName to C:\Windows\Temp\permissions.txt"
  $serviceName | Out-File -FilePath "C:\Windows\Temp\Servicenames.txt" -Append
  Write-Host "Added service name: $serviceName to C:\Windows\Temp\Servicenames.txt"
}

# Retrieve binary path names from Servicenames.txt and save to services.txt
Get-Content -Path "C:\Windows\Temp\Servicenames.txt" | ForEach-Object {
  $binaryPath = (Get-WmiObject -Class Win32_Service | Where-Object { $_.Name -eq $_ }).PathName
  $binaryPath -replace "=", "'" | Out-File -FilePath "C:\Windows\Temp\services.txt" -Append
}

# Retrieve BINARY_PATH_NAME from services.txt and save to path.txt
Get-Content -Path "C:\Windows\Temp\services.txt" | ForEach-Object {
  $binaryPathName = (Get-Service $_).BinaryPathName
  $binaryPathName | Out-File -FilePath "C:\Windows\Temp\path.txt" -Append
}
