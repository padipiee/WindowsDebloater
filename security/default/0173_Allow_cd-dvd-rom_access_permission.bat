:: @N@Allow_cd-dvd-rom_access_permission@N@
:: Fixing CD/DVD ROM Access Denied - Grant Permission

reg add HKLM\SYSTEM\ControlSet001\Control\Class\{4D36E965-E325-11CE-BFC1-08002BE10318} /v DeviceType /t REG_DWORD /d 0x00000001
reg add HKLM\SYSTEM\ControlSet001\Control\Class\{4D36E965-E325-11CE-BFC1-08002BE10318} /v DeviceCharacteristics /t REG_DWORD /d 00000100