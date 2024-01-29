
<#
.SYNOPSIS
This script disables unsafe services and stops unneeded services for privacy.

.DESCRIPTION
The script disables a list of unsafe services and stops unneeded services for privacy. It also deletes or disables specific services related to privacy.

.PARAMETER None

.EXAMPLE
.\0010_Disable_unsafe_services.ps1
#>


$unsafe_services = "RemoteRegistry", "TermService", "TrkWks", "DPS", "SensorDataService", "SensorService", "SensrSvc"
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


# ;;; 5.25 (L2) Ensure 'Remote Registry (RemoteRegistry)' is set to 'Disabled'
# ;[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteRegistry]
# ; 2 = Automatic
# ; 3 = Manual
# ; 4 = Disabled (Default / CIS)
# ;"Start"=dword:0000004

# #Remote Registry (RemoteRegistry)'
# $indextest += 1
# $chaine = $null
# $traitement = $null
# $exist = $null
# $id = "SS" + "$indextest"
# $chaine = "$id" + ";" + "(L2)Ensure 'Remote Registry (RemoteRegistry)' is set to 'Disabled' or 'Not Installed', value must be 4 or not installed" + ";"
# $exist = Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\RemoteRegistry"
# if ( $exist -eq $true) {
#  $traitement = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\RemoteRegistry"|Select-Object Start
#  $traitement = $traitement.Start
# }
# else {
#  $traitement = "It s not installed"
# }


#   # 5.25 (L2) Ensure 'Remote Registry (RemoteRegistry)' is set to 'Disabled'
#   Registry 'RemoteRegistry' {
#     Ensure      = 'Present'
#     Key         = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RemoteRegistry'
#     ValueName   = 'Start'
#     ValueType   = 'DWord'
#     ValueData   = '4'
# } 
