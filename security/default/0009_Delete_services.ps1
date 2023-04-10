#:: Deleting services...

$spy_services = @(
    "DiagTrack",
    "dmwappushservice",
    "diagnosticshub.standardcollector.service",
    "DcpSvc",
    "WerSvc",
    "PcaSvc",
    "DoSvc",
    "WMPNetworkSvc",
    "XblAuthManager",
    "XblGameSave",
    "XboxNetApiSvc",
    "xboxgip",
    "wlidsvc",
    "lfsvc",
    "NcbService",
    "WbioSrvc",
    "LicenseManager",
    "OneSyncSvc",
    "CDPSvc",
    "CDPUserSvc",
    "MapsBroker",
    "PhoneSvc",
    "RetailDemo",
    "WalletService"
)

$spy_svc_found = $false

foreach ($service in $spy_services) {
    $serviceStatus = Get-Service -Name $service -ErrorAction SilentlyContinue

    if (!$serviceStatus) {
        Write-Host "Current service: $service is going to be stopped and deleted...."
        Stop-Service -Name $service -ErrorAction SilentlyContinue
        #& sc.exe delete $service | Out-Null
        & sc.exe delete $service 
        $spy_svc_found = $true
    }
}

if (!$spy_svc_found) {
    Write-Host "No spyware services found."
}
