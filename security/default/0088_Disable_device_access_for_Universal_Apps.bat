::@N@Deny_Apps_Access@N@
::@@@DeviceAccess@@@ @@@Apps Access@@@
::@RO@0162_Allow_global_apps_use_your_camera.bat@RC@
::Deny
:: https://techcult.com/wiki/allow-or-deny-apps-access-to-camera-in-windows-10/#Method_2_Allow_or_Deny_Apps_Access_to_Camera_using_Registry
:: https://www.joseespitia.com/2017/03/06/registry-keys-for-windows-10-privacy-settings/
:: https://www.c-amie.co.uk/technical/windows-10-registry-paths-for-privacy-settings/
:: https://tuxicoman.jesuislibre.net/blog/wp-content/uploads/Windows10_Telemetrie_1709.pdf
:: https://www.ssi.gouv.fr/uploads/2017/01/np_securisation_windows10_collecte_de_donnees_v1.2.pdf


::@@@PhoneCall@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{235B668D-B2AC-4864-B49C-ED1084F6C9D3}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Let apps use Mic@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Let apps access my contacts@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Let apps access my call history@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Let apps access my emaily@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Let apps access text/mms@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Let apps control radios@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Location On/Off@@@ @@@Disable Location@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 1 /f
:: Type: REG_DWORD, Length: 4, Data: 0

::@@@Let apps access my name, picture and other account info@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Let apps access my calendar@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@[b1607] Location Service@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E6AD100E-5F4E-44CD-BE0F-2265D88D14F5}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@[b1511] Has something to do with Device Access [b1607] Appears deprecated@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E83AF229-8640-4D18-A213-E22675EBB2C3}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@[b1607] Let your apps automatically share and sync info with wireless devices tat don’t explicitly pair with your PC, tablet or phone@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Deny" /f 

::@@@[b1607] Let apps access notifications@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8c501030-f8c2-40b2-8b3b-e6605788ff39}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@@@@Activity meter@@@ @@@@@@SettingsHandlers_Privacy.dll@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{B19F89AF-E3EB-444B-8DEA-202575A71599}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@Activity@@@ @@@ActivitySensor_InterfaceInstall@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9D9E0118-1807-4F2E-96E4-2CE57142E196}" /v "Value" /t REG_SZ /d "Deny" /f

::@@@[b1703] Tasks@@@
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E390DF20-07DF-446D-B962-F5C953062741}" /v "Value" /t REG_SZ /d "Deny" /f



:: Microsoft.Microsoft3DViewer_8wekyb3d8bbwe!Microsoft.Microsoft3DViewer
:: Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\Microsoft.Microsoft3DViewer_7.2010.15012.0_x64__8wekyb3d8bbwe
:: pkgSid : S-1-15-2-3739514657-3828455176-2936196785-2025316370-1894713875-3268641221-1640234959



:: TODO ! Below reg seems to not disable 3DViewer device access permissions !
:: Mitigation :  Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\S-1-15-2-3739514657-3828455176-2936196785-2025316370-1894713875-3268641221-1640234959" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\S-1-15-2-3739514657-3828455176-2936196785-2025316370-1894713875-3268641221-1640234959\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\S-1-15-2-3739514657-3828455176-2936196785-2025316370-1894713875-3268641221-1640234959\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Deny" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DeviceAccess\S-1-15-2-3739514657-3828455176-2936196785-2025316370-1894713875-3268641221-1640234959\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f

::Enable
::Name: Value
::Type: REG_SZ
::Data: Allow
::
::Disable
::Name: Value
::Type: REG_SZ
::Data: Deny