<#
.SYNOPSIS
Disables the Steps Recorder feature in Windows.
# Disable Steps Recorder 
# Steps Recorder (called Problems Steps Recorder in Windows , is a program that helps you troubleshoot 
# a problem on your device by recording the exact steps you took when the problem occurred

.DESCRIPTION
This script checks if the registry key "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" exists. If it exists, it retrieves the current value of the "DisableUAR" property. If the current value is not already set to 1, it sets the value to 1 using the Set-ItemProperty cmdlet. The script provides feedback on the initial value of "DisableUAR" and whether it was changed or not.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
Disable-StepsRecorder

This example demonstrates how to use the script to disable the Steps Recorder feature in Windows.

.NOTES
Author: [Author Name]
Date: [Date]
Version: [Version Number]
#>
# Check if registry key exists
if (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat") {
  # Get the current value of DisableUAR
  $currentValue = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR"
  
  # Display the initial value
  Write-Host "[0019_Disable_Steps_Recorder] Initial value of DisableUAR: $currentValue"
  
  # Set the value to 1 only if it is not already set to 1
  if ($currentValue -ne 1) {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableUAR" -Value 1 -Type DWORD -Force
    Write-Host "[0019_Disable_Steps_Recorder] DisableUAR was set to 1."
  } else {
    Write-Host "[0019_Disable_Steps_Recorder] DisableUAR is already set to 1 [no change]."
  }
}


