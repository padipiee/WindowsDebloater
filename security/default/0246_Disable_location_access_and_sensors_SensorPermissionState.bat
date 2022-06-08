
:: REF 0086_0086_Disable_location_access_and_sensors
:: ceasing ISVC service (geolocation)
:: The value you have to add is 0 for off and 1 for on.
:: Type: REG_DWORD, Length: 4, Data: 0

::Permissions
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f 

::Overrides
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f 
:: https://www.techwibe.com/stop-or-disable-lfsvc-or-turn-off-location-service-of-windows-10/


