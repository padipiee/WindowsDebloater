::Disable AllowInsecureGuestAuth
:: REF CIS 18.5.8.1 (L1) Ensure 'Enable insecure guest logons' is set to 'Disabled'

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters /v AllowInsecureGuestAuth /t reg_dword /d 0
reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters /v AllowInsecureGuestAuth
