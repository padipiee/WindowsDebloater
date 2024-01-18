<#
.SYNOPSIS
This script checks if it is running with administrator privileges and, if not, restarts itself with elevated privileges.

.DESCRIPTION
The script first checks if the current user is a member of the Administrator group. If the user is an administrator, it displays a message indicating that the script is running with administrator privileges. If the user is not an administrator, the script creates a new elevated process to start PowerShell and passes the current script path and name as a parameter. The new process is started with elevated privileges using the "runas" verb. The script then exits from the current unelevated process.

The script also includes some example code related to Windows Update. It calls the Install-WindowsUpdate function and retrieves the Windows Update history for the last 30 days.

.PARAMETER None

.EXAMPLE
Check-RunAsAdministrator
This command checks if the script is running with administrator privileges.

.NOTES
Author: Unknown
Date: Unknown
#>

Function Invoke-RunAsAdministrator() {
  #Get current user context
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  
  #Check user is running the script is member of Administrator Group
  if ($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    Write-host "Script is running with Administrator privileges!"
  }
  else {
    #Create a new Elevated process to Start PowerShell
    $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
 
    # Specify the current script path and name as a parameter
    $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
 
    #Set the Process to elevated
    $ElevatedProcess.Verb = "runas"
 
    #Start the new elevated process
    [System.Diagnostics.Process]::Start($ElevatedProcess)
 
    #Exit from the current, unelevated, process
    Exit
 
  }
}
 
#Invoke Script is running with Elevated Privileges
Invoke-RunAsAdministrator
 
#Place your script here.
write-host "Welcome let's WindowsUpdate !"

#Get-WURebootStatus

##
Install-WindowsUpdate

##
#Get-WURebootStatus

#Powershell.exe -ExecutionPolicy RemoteSigned Get-WUHistory
#Get-WUHistory | Format-Table -AutoSize
Get-WUHistory -MaxDate (Get-Date).AddDays(-30) -Last 10

Start-Sleep -Seconds 15
