
<#
.SYNOPSIS
This script disables unsafe services and stops unneeded services for privacy.

.DESCRIPTION
The script disables a list of unsafe services and stops unneeded services for privacy. It also deletes or disables specific services related to privacy.

.PARAMETER None

.EXAMPLE
.\0010_Disable_unsafe_services.ps1
#>


$unsafe_services = "TermService", "TrkWks", "DPS", "SensorDataService", "SensorService", "SensrSvc"
foreach ($service in $unsafe_services) {
    $serviceStatus = Get-Service -Name $service | Select-Object -ExpandProperty Status
    if ($serviceStatus -eq "Running") {
        Write-Host "[0010_Disable_unsafe_services] Stopping and disabling service: $service"
        Stop-Service -Name $service -Force
        Set-Service -Name $service -StartupType Disabled
    }
    elseif ($serviceStatus -eq "Stopped") {
        Write-Host "[0010_Disable_unsafe_services] Service: $service is already disabled"
    }
    else {
        Write-Host "[0010_Disable_unsafe_services] Service: $service is not found"
    }
}


