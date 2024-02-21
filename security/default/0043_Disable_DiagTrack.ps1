<#
.SYNOPSIS
Disables DiagTrack service by modifying the registry keys.

.DESCRIPTION
This script disables the DiagTrack service by setting the value of the "Start" property in the registry keys to 4. It checks if the registry keys exist and if the current value is already set to the target value before making any changes.

.PARAMETER None

.EXAMPLE
.\0043_Disable_DiagTrack.ps1
Disables the DiagTrack service by modifying the registry keys.

.NOTES
Author: [Your Name]
Date: [Current Date]
Version: 1.0
#>
Write-Host "[0043_Disable_DiagTrack] Disable DiagTrack"

# Define the target value
$targetValue = 4

# Define the registry keys
$keys = @(
    "HKLM:\SYSTEM\ControlSet001\Services\DiagTrack",
    "HKLM:\SYSTEM\CurrentControlSet\Services\DiagTrack"
)

foreach ($key in $keys) {
    # Check if the key exists
    if (Test-Path $key) {
        # Get the current value
        $currentValue = Get-ItemPropertyValue -Path $key -Name "Start" -ErrorAction SilentlyContinue

        # Check if the current value is the target value
        if ($currentValue -eq $targetValue) {
            Write-Host "[0043_Disable_DiagTrack] The value of 'Start' in '$key' is already '$targetValue'."
        } else {
            # Set the value
            Set-ItemProperty -Path $key -Name "Start" -Value $targetValue

            Write-Host "[0043_Disable_DiagTrack] The value of 'Start' in '$key' has been set to '$targetValue'."
        }
    } else {
        Write-Host "[0043_Disable_DiagTrack] The registry key '$key' does not exist."
    }
}