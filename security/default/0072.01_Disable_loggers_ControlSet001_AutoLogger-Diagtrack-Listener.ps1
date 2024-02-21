<#
.SYNOPSIS
Disables loggers by modifying registry keys.

.DESCRIPTION
This script disables loggers by checking if specific registry keys exist and setting their "Start" value to 0 if it is not already set to 0.

.PARAMETER registryPath1
The registry path for the first logger.

.PARAMETER registryPath2
The registry path for the second logger.

.PARAMETER registryPath3
The registry path for the third logger.

.PARAMETER targetValue
The value to set the "Start" property of the registry keys to.

.NOTES
Author: [Your Name]
Date: [Current Date]

.EXAMPLE
Disable-Loggers -registryPath1 "HKLM:\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" -registryPath2 "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" -registryPath3 "HKLM:\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" -targetValue 0
#>
$registryPath1 = "HKLM:\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener"


$targetValue = 0

# Function to set registry key value and display message
function Set-RegistryKeyValue($registryPath, $targetValue) {
    $currentValue = Get-ItemProperty -Path $registryPath -Name "Start" | Select-Object -ExpandProperty "Start"
    if ($currentValue -ne $targetValue) {
        Set-ItemProperty -Path $registryPath -Name "Start" -Value $targetValue
        Write-Host "[0072.01_Disable_loggers_ControlSet001_AutoLogger-Diagtrack-Listener] Registry key $registryPath has been set to $targetValue"
    } else {
        Write-Host "[0072.01_Disable_loggers_ControlSet001_AutoLogger-Diagtrack-Listener] Registry key $registryPath is already set to $targetValue"
    }
}

# Check if registry keys exist and set the target value if not on target
if (Test-Path $registryPath1) {
    Set-RegistryKeyValue -registryPath $registryPath1 -targetValue $targetValue
} else {
    Write-Host "[0072.01_Disable_loggers_ControlSet001_AutoLogger-Diagtrack-Listener] Registry key $registryPath1 does not exist"
}


