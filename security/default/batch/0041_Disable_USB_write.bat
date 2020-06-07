:: Disable the possibility to write with USB port
:: [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies] “WriteProtect”=dword:00000001
:: !!CAREFUL BEFORE APPLYING!!

reg add "HKLM\SYSTEM\CurrentControlSet\Control\StorageDevicePolicies" /v "WriteProtect" /t REG_DWORD /d "1" /f
reg query "HKLM\System\CurrentControlSet\Control\StorageDevicePolicies"