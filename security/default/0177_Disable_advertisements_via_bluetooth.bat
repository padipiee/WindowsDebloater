::@N@Disable advertisements via bluetooth@N@

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Bluetooth" /v "AllowAdvertising" /t REG_DWORD /d 0 /f

::https://github.com/AcaplaStd/WindowsConfigurator/blob/master/doit.cmd