
<#
.SYNOPSIS
Lists all scheduled tasks.

.DESCRIPTION
This script uses the schtasks command to query and retrieve information about all scheduled tasks on the system. It then filters the results to exclude the "TaskName" column and formats the output as a list.

.EXAMPLE
TaskName    : \Microsoft\Office\OfficeTelemetryAgentFallBack2016
Task To Run : C:\Program Files (x86)\Microsoft Office\root\Office16\msoia.exe scan upload mininterval:2880

.EXAMPLE
TaskName    : \Microsoft\Office\OfficeTelemetryAgentLogOn2016
Task To Run : C:\Program Files (x86)\Microsoft Office\root\Office16\msoia.exe scan upload
#>
# list all scheduled tasks
# check via taskschd.msc 

schtasks /query /v /fo csv | ConvertFrom-CSV | Select-Object -Property "TaskName","Task To Run" | Where-Object {$_.TaskName -notcontains "TaskName"} | Format-List

