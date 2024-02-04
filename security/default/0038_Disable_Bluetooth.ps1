<#
.SYNOPSIS
Disables the Bluetooth quick action in the Windows 10 Action Center.

.DESCRIPTION
This script checks if the registry key for the Bluetooth quick action exists and if the current value is different from the target value. If the key exists and the value is different, it updates the value to disable the Bluetooth quick action. If the key does not exist, it outputs a message indicating that the registry key does not exist.

.PARAMETER None

.EXAMPLE
Disable-BluetoothQuickAction

This example runs the script to disable the Bluetooth quick action in the Windows 10 Action Center.

.NOTES
Author: [Your Name]
Date: [Current Date]
Version: 1.0
#>



$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\"
$items = Get-ChildItem -Path $path | Select-Object -ExpandProperty Name
foreach ($item in $items) {
  Write-Output $item
}


$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\"
$items = Get-ChildItem -Path $path | Where-Object { $_.Name -like 'A*' } | Select-Object -ExpandProperty Name

if ($items) {
  Write-Output "[0038_Disable_Bluetooth] Found the following items starting with 'A':"
  foreach ($item in $items) {
    Write-Output $item
  }
}
else {
  Write-Output "[0038_Disable_Bluetooth] No items starting with 'A' found."
}


#[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ActionCenter\Quick Actions\All\SystemSettings_Device_BluetoothQuickAction]
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\ActionCenter\Quick Actions\All\SystemSettings_Device_BluetoothQuickAction"
#\HKEY_LOCAL_M\SOFTWARE\Microsoft\Windows\CurrentVersion\ActionCenter\Quick Actions\All\SystemSettings_Device_BluetoothQuickAction
$name = "Type"
$targetValue = 1

Get-ItemProperty -Path $path -Name $name

if (Test-Path $path) {
  $currentValue = Get-ItemProperty -Path $path -Name $name
  Write-Output "[0038_Disable_Bluetooth] Current value for $path/$name : $currentValue"

  if ($currentValue -ne $targetValue) {
    Set-ItemProperty -Path $path -Name $name -Value $targetValue
    Write-Output "[0038_Disable_Bluetooth] Current value for $path/$name has been changed to $targetValue"
  }
  else {
    Write-Output "[0038_Disable_Bluetooth] Current value for $path/$name Value is already set to $targetValue"
  }
}
else {
  Write-Output "[0038_Disable_Bluetooth]  Registry key $path/$name does not exist"
}

