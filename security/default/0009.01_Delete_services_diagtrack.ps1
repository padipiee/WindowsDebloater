<#
.SYNOPSIS
Deletes specified services.

.DESCRIPTION
This script deletes a list of services that are commonly considered intrusive on privacy. It iterates through the list of services and checks if each service exists. If a service is found, it stops the service and deletes it using the sc.exe command.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
.\0009_Delete_services.ps1
Deletes intrusive services if found.

.NOTES
Author: [Your Name]
Date: [Current Date]
#>

#DiagTrack, also known as the Universal Telemetry Client (UTC). File located in %SystemRoot%\system32\diagtrack.dll


$spy_services = @(
    "DiagTrack"
)

foreach ($service in $spy_services) {
    $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue

    if ($serviceStatus) {
        Write-Host "[0009.01_Delete_services_diagtrack] Service found: $($serviceStatus.Name) - $($serviceStatus.DisplayName) - $($serviceStatus.Path)"
        Write-Host "[0009.01_Delete_services_diagtrack] Stopping and deleting service $($serviceStatus.Name)..."
        Stop-Service -Name $service -ErrorAction SilentlyContinue
        & sc.exe delete $service | Out-Null

        # Check if service still exists
        $serviceStatusAfterDeletion = Get-Service -Name $service -ErrorAction SilentlyContinue
        if ($serviceStatusAfterDeletion) {
            Write-Host "[0009.01_Delete_services_diagtrack] Failed to delete service: $($serviceStatusAfterDeletion.Name) - $($serviceStatusAfterDeletion.DisplayName) - $($serviceStatusAfterDeletion.Path)"
        }
        else {
            Write-Host "[0009.01_Delete_services_diagtrack Service deleted successfully: $service"
        }
    }
}

if ($serviceStatus) {
    Write-Host "[0009.01_Delete_services_diagtrack] Service found: $($serviceStatus.Name) - $($serviceStatus.DisplayName) - $($serviceStatus.Path)"
    Write-Host "[0009.01_Delete_services_diagtrack] Stopping and deleting service $($serviceStatus.Name)..."
    Stop-Service -Name $service -ErrorAction SilentlyContinue
    #& sc.exe delete $service | Out-Null
    & sc.exe delete $service 
}
