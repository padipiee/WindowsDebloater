# Retrieve service binary path names and save to permissions.txt
Get-WmiObject -Class Win32_Service | ForEach-Object {
  $serviceName = $_.Name
  $binaryPath = $_.PathName
  if ($binaryPath -match ".*system32.*") {
      return
  }
  $binaryPath -replace "=", "'" | Out-File -FilePath "C:\Windows\Temp\permissions.txt" -Append
  Write-Host "Retrieve service binary path names and save to C:\Windows\Temp\permissions.txt..."
}

# Retrieve service names and save to Servicenames.txt
Get-Service | Select-Object -ExpandProperty Name | Out-File -FilePath "C:\Windows\Temp\Servicenames.txt"

# Retrieve binary path names from Servicenames.txt and save to services.txt
Get-Content -Path "C:\Windows\Temp\Servicenames.txt" | ForEach-Object {
  $serviceName = $_
  $binaryPath = (Get-WmiObject -Class Win32_Service | Where-Object { $_.Name -eq $serviceName }).PathName
  $binaryPath -replace "=", "'" | Out-File -FilePath "C:\Windows\Temp\services.txt" -Append
}

# Retrieve BINARY_PATH_NAME from services.txt and save to path.txt
Get-Content -Path "C:\Windows\Temp\services.txt" | ForEach-Object {
  $serviceName = $_
  $binaryPathName = (Get-Service $serviceName).BinaryPathName
  $binaryPathName | Out-File -FilePath "C:\Windows\Temp\path.txt" -Append
}
