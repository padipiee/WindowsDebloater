Get-PnpDevice -Class 'Mouse' | Format-List InstanceId

$instanceId = "HID\ELAN0511&COL01\5&2C8FDAAE&0&0000"
$device = Get-PnpDevice | Where-Object { $_.InstanceId -eq $instanceId }
Get-PnpDeviceProperty -InstanceId $device.InstanceId
