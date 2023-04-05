echo  Disable Windows Customer Experience Improvement Program 
:: HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows

:: This policy setting turns off the Windows Customer Experience Improvement Program
:: If you enable this policy setting, all users are opted out of the Windows Customer Experience Improvement Program.


reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient" /v "CorporateSQMURL" /t REG_SZ /d "0.0.0.0" /f 
