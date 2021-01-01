:: Harden MS Office Word against DDE malspam attacks
:: Disables Macros, enables ProtectedView
:: ---------------------

reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options\WordMail" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f

:: https://docs.microsoft.com/en-us/security-updates/securityadvisories/2017/4053440