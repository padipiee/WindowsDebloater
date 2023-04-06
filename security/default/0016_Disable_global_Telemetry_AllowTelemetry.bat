echo  Disable global Telemetry 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f 
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d 4 /f 

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowTelemetry" /v "value" /t REG_DWORD /d 0 /f
:: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.DataCollection::AllowTelemetry


@REM Computer
@REM SOFTWARE\Policies\Microsoft\Windows\DataCollection
@REM AllowTelemetry
@REM DWORD:0


@REM ;;; 18.9.16.1 (L1) Ensure 'Allow Telemetry' is set to 'Enabled: 0 - Security [Enterprise Only]'
@REM [HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection]
@REM ; <deleted> = (Default)
@REM ; 0 = Security: Security data only (CIS)
@REM ; 1 = Basic: Security + basic system and quality data
@REM ; 2 = Enhanced: Basic + enhanced insights and advanced reliability data
@REM ; 3 = Full: Enhanced + full diagnostics data
@REM "AllowTelemetry"=dword:0000000

