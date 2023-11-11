<#
.SYNOPSIS
Lists all running processes, services and tasks.

.DESCRIPTION
This script lists all running processes, services and tasks on the local machine.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
./0336_List_processes_tasks.ps1
This command will list all running processes, services and tasks on the local machine.

.NOTES
Author: Unknown
Date: Unknown
#>
Get-Process | Format-Table -AutoSize
net start
Get-Service
Get-WmiObject -Query "Select * from Win32_Process" | Where-Object {$_.Name -notlike "svchost*"} | Select-Object Name, Handle, @{Label="Owner";Expression={$_.GetOwner().User}} | Format-Table -AutoSize
