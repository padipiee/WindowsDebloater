<#
.SYNOPSIS
Deletes Microsoft application experience scheduled tasks (taskschd.msc) and denies write permissions to the corresponding directories.

.DESCRIPTION
This script deletes specific Microsoft application experience scheduled tasks and denies write permissions to the directories associated with those tasks. It checks if each task exists before deleting it, and outputs the result for each task.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
.\0354_Deleting_microsoft_application_experience_sheduled_tasks.ps1
Deletes the specified Microsoft application experience scheduled tasks and denies write permissions to the corresponding directories.

.NOTES

#>
# Define the tasks to delete
$spy_tasks = @(
    "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser",
    "Microsoft\Windows\Application Experience\ProgramDataUpdater",
    "Microsoft\Windows\Application Experience\SdbinstMergeDbTask",
    "Microsoft\Windows\Application Experience\StartupAppTask"
)

# Define the tasks directory
$tasks_dir = Join-Path $env:SystemRoot "System32\Tasks"

# Loop over the tasks
foreach ($task in $spy_tasks) {
    # Check if the task exists . suppress the error message if the task does not exist
    $taskExists = $null -ne (schtasks /query /tn $task 2>$null)

    if ($taskExists) {
        # Delete the task
        schtasks /delete /tn $task /f > $null

        # Create a directory with the same name as the task
        $dir_path = Join-Path $tasks_dir ($task -replace '\\', '/')
        New-Item -ItemType Directory -Path $dir_path -Force | Out-Null

        # Deny write permissions to the directory
        icacls $dir_path /deny 'Everyone:(OI)(CI)W' > $null

        # Output the result
        Write-Output "$task [OK]"
    }
    else {
        # Output a message indicating that the task does not exist
        Write-Output "Task $task does not exist so not deleted"
    }
}