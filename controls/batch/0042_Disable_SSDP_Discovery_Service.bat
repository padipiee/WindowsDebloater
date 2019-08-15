
REM Disable SSDP Discovery Service

REM Discovers networked devices and services that use the SSDP discovery protocol, such as UPnP devices.
REM Also announces SSDP devices and services running on the local computer. 
REM If this service is stopped, SSDP-based devices will not be discovered. 
REM If this service is disabled, any services that explicitly depend on it will fail to start.
REM https://computerstepbystep.com/ssdp-discovery-service-xp.html

REM  Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SSDPSRV
REM  Automatic - 2
REM  Manual - 3
REM  Disabled - 4
REM  Automatic (Delayed Start) - 2 

reg add "HKLM\SYSTEM\CurrentControlSet\services\SSDPSRV" /v Start /t REG_DWORD /d 4 /f