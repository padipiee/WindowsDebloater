
#:: Disable unsafe services...

$unsafe_services = "RemoteRegistry","TermService","TrkWks","DPS","SensorDataService","SensorService","SensrSvc"
foreach ($service in $unsafe_services) {
    Write-Host "Current service: $service is going to be stopped and disabled"
    Stop-Service -Name $service -Force
    Set-Service -Name $service -StartupType Disabled
}

# Privacy - Stop unneeded services.
Stop-Service -Name "DiagTrack", "dmwappushservice", "RemoteRegistry", "RetailDemo", "WinRM", "WMPNetworkSvc"

# Privacy - Delete, or disable, unneeded services.
Set-Service -Name "RemoteRegistry" -StartupType Disabled
Set-Service -Name "RetailDemo" -StartupType Disabled
Set-Service -Name "WinRM" -StartupType Disabled
Set-Service -Name "WMPNetworkSvc" -StartupType Disabled
Remove-Service -Name "DiagTrack" -Force
Remove-Service -Name "dmwappushservice" -Force



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
