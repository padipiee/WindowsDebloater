<#
.SYNOPSIS
Deletes the Microsoft Compatibility Appraiser scheduled task.
# Deleting Microsoft Compatibility Appraiser scheduled task
# This is deleting Telemetry task activated despite you deactivate Telemetry from Settings...
# %windir%\system32\compattelrunner.exe


.DESCRIPTION
This script deletes the Microsoft Compatibility Appraiser scheduled task if it exists. It uses the schtasks command to query the task and delete it if found.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
.\0026-001_Deleting_microsoft_task_Microsoft_Compatibility_Appraiser_only.ps1
Deletes the Microsoft Compatibility Appraiser scheduled task.

.NOTES
Author: [Your Name]
Date: [Current Date]
#>
$thetasks = "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"

foreach ($task in $thetasks) {
	try {
		$taskExists = schtasks /query /tn $task 2>$null
	}
	catch {
		Write-Host "Task $task does not exist."
		Write-Host "[0026.01_Deleting_microsoft_task_Microsoft_Compatibility_Appraiser_only] Task Microsoft Compatibility Appraiser scheduled does not exist."
		continue
	}

	if ($taskExists -eq 0) {
		Write-Host "Deleting task: $task"
		Write-Host "[0026.01_Deleting_microsoft_task_Microsoft_Compatibility_Appraiser_only] Deleting Microsoft Compatibility Appraiser scheduled task"
		schtasks /delete /tn $task /f
	}
	else {
		Write-Host "[0026.01_Deleting_microsoft_task_Microsoft_Compatibility_Appraiser_only] Task $task already deleted."
	}
}