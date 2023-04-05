:: Disable CEIPEnable (Enables the Windows Customer Experience Improvement program.)
:: https://learn.microsoft.com/en-us/windows/win32/devnotes/ceipenable
:::: https://getadmx.com/?Category=Windows_10_2016&Policy=Microsoft.Policies.InternetCommunicationManagement::CEIPEnable
:: Privacy - Disable CEIP for apps, and generally.
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\AppV\CEIP" /v "CEIPEnable" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f

      @REM # 18.8.22.1.13 (L2) Ensure 'Turn off Windows Customer Experience Improvement Program' is set to 'Enabled'
      @REM Registry 'CEIPEnable' {
      @REM     Ensure     = 'Present'
      @REM     Key        = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\SQMClient\Windows'
      @REM     ValueName  = 'CEIPEnable'
      @REM     ValueType  = 'DWord'
      @REM     ValueData  = '0'
      @REM }

@REM ;;; 18.8.22.1.13 (L2) Ensure 'Turn off Windows Customer Experience Improvement Program' is set to 'Enabled'
@REM [HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\SQMClient\Windows]
@REM ; <deleted> = (Default)
@REM ; 0000000 = Off (CIS)
@REM ; 0000001 = On
@REM "CEIPEnable"=dword:0000000
