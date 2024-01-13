<#
.SYNOPSIS
This script retrieves information about mouse drivers and displays the details of a specific mouse device.

.DESCRIPTION
The script first retrieves a list of all mouse devices using the Get-PnpDevice cmdlet and filters them by the 'Mouse' class. It then formats the list to display the InstanceId of each mouse device.

Next, it assigns a specific InstanceId to the $instanceId variable. This InstanceId represents a particular mouse device.

The script uses the Get-PnpDevice cmdlet again to retrieve information about all devices and filters them based on the InstanceId matching the $instanceId variable. This allows it to find the specific mouse device.

Finally, it uses the Get-PnpDeviceProperty cmdlet to retrieve and display the properties of the selected mouse device.

.PARAMETER instanceId
The InstanceId of the mouse device to retrieve details for.

.EXAMPLE
PS> .\0358_mouse_drivers_details.ps1
  Displays the InstanceId of all mouse devices and the properties of a specific mouse device.

#>
Get-PnpDevice -Class 'Mouse' | Format-List InstanceId

$instanceId = "HID\ELAN0511&COL01\5&2C8FDAAE&0&0000"
$device = Get-PnpDevice | Where-Object { $_.InstanceId -eq $instanceId }
Get-PnpDeviceProperty -InstanceId $device.InstanceId
