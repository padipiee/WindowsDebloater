REM This batch script searches for problematic drivers on the system using the driverquery.exe command. The output is formatted as a table and includes additional information about each driver, such as its signed status.
:: Search problematic drivers
:: https://www.loldrivers.io/  

::PS C:\WINDOWS\system32> driverquery.exe /fo table /si
::
::DeviceName                     InfName       IsSigned Manufacturer             
::============================== ============= ======== =========================
::Local Print Queue              printqueue.in TRUE     Microsoft                
::Local Print Queue              printqueue.in TRUE     Microsoft                
::Local Print Queue              printqueue.in TRUE     Microsoft                
::Local Print Queue              printqueue.in TRUE     Microsoft                
::Generic software device        c_swdevice.in TRUE     Microsoft                
::Generic software device        c_swdevice.in TRUE     Microsoft     

:: driverquery.exe with format table and signed status
driverquery.exe /fo table /si


::PS C:\WINDOWS\system32> Get-WmiObject -Class Win32_SystemDriver | Format-Table
::
::DisplayName                                Name                       State   Status Started
::-----------                                ----                       -----   ------ -------
::1394 OHCI Compliant Host Controller        1394ohci                   Stopped OK       False
::3ware                                      3ware                      Stopped OK       False
::Acer Airplane Mode Controller              AcerAirplaneModeController Running OK        True
::Microsoft ACPI Driver                      ACPI                       Running OK        True