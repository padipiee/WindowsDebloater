:: Disable Word 2016 Default DDE links activation
REM Value: DontUpdateLinks
REM Dword: 00000001
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options\WordMail" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f

:: https://docs.microsoft.com/en-us/security-updates/securityadvisories/2017/4053440
:: https://www.peerlyst.com/posts/windows-dde-registry-tweaks-roger-barnett?utm_source=linkedin&utm_medium=Application_Share&utm_content=peerlyst_post&utm_campaign=peerlyst_shared_post


