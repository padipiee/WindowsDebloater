    sc.exe stop XboxGipSvc
    sc.exe config XboxGipSvc start= disabled
    
    sc.exe stop XblAuthManager
    sc.exe config XblAuthManager start= disabled
    sc.exe stop XblGameSave
    sc.exe config XblGameSave start= disabled
    sc.exe stop XboxNetApiSvc
    sc.exe config XboxNetApiSvc start= disabled


::    ;;; 5.41 (L1) Ensure 'Xbox Accessory Management Service (XboxGipSvc)' is set to 'Disabled'
::;[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxGipSvc]
::; 2 = Automatic
::; 3 = Manual (Default)
::; 4 = Disabled (CIS)
::; NON-COMPLIANCE TO NOT DISRUPT COMMON HOME FEATURES
::;"Start"=dword:0000004

::
::     # 5.41 (L1) Ensure 'Xbox Accessory Management Service (XboxGipSvc)' is set to 'Disabled'
::     Registry 'XboxGipSvc' {
::         Ensure      = 'Present'
::         Key         = 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XboxGipSvc'
::         ValueName   = 'Start'
::         ValueType   = 'DWord'
::         ValueData   = '4'
::     } 

@REM #Xbox Accessory Management Service (XboxGipSvc)'
@REM $indextest += 1
@REM $chaine = $null
@REM $traitement = $null
@REM $exist = $null
@REM $id = "SS" + "$indextest"
@REM $chaine = "$id" + ";" + "(L1)Ensure Xbox Accessory Management Service (XboxGipSvc) is set to 'Disabled' or 'Not Installed', value must be 4 or not installed" + ";"
@REM $exist = Test-Path "HKLM:\SYSTEM\CurrentControlSet\Services\XboxGipSvc"
@REM if ( $exist -eq $true) {
@REM  $traitement = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Services\XboxGipSvc"|Select-Object Start
@REM  $traitement = $traitement.Start
@REM }
@REM else {
@REM  $traitement = "It s not installed"
@REM }
