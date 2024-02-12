<#
.SYNOPSIS
Disables the WMI Autologger for CloudExperienceHostOobe.

.DESCRIPTION
This script disables the WMI Autologger for CloudExperienceHostOobe by modifying the registry value.

.PARAMETER regPath
The registry path where the Autologger for CloudExperienceHostOobe is located.

.PARAMETER targetValue
The desired value to set for the Autologger. If the current value is already equal to the target value, no changes will be made.

.EXAMPLE
Disable-WMIAutologger -regPath "HKLM:\SYSTEM\ControlSet001\Control\WMI\Autologger\CloudExperienceHostOobe" -targetValue 0

This example disables the WMI Autologger for CloudExperienceHostOobe by setting the registry value to 0.

.NOTES
Author: [Your Name]
Date: [Current Date]
Version: 1.0
#>
$regPath = "HKLM:\SYSTEM\ControlSet001\Control\WMI\Autologger\CloudExperienceHostOobe"
$targetValue = 0

if (Test-Path $regPath) {
    $currentValue = Get-ItemProperty -Path $regPath -Name "Start" | Select-Object -ExpandProperty "Start"
    if ($currentValue -eq $targetValue) {
        Write-Host "[0073_Disable_WMI_Autologger_CloudExperienceHostOobe] The value for $regPath is already set to $targetValue."
    } else {
        Set-ItemProperty -Path $regPath -Name "Start" -Value $targetValue -Force
        Write-Host "[0073_Disable_WMI_Autologger_CloudExperienceHostOobe] The value for $regPath has been set to $targetValue."
    }
} else {
    Write-Host "[0073_Disable_WMI_Autologger_CloudExperienceHostOobe] The registry path $regPath does not exist."
}

# :: REF  https://www.anoopcnair.com/mdm-diagnostics-tool-windows-autopilot/
# :: Where is the location of CloudExperienceHost? It is part of system apps within c:\windows\systemapps folder 
# :: In Windows Autopilot deployment, CloudExperienceHost process communicates with Azure. 
# :: To trace CloudExperienceHost process activity, MDM Diagnostics Tool generates Event Tracing Logs (this is called ETW – Event Tracing for Windows)