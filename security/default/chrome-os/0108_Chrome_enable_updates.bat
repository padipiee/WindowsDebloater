
REM https://superuser.com/questions/645845/how-do-i-disable-google-chrome-silent-updates
REM HKLM=HKEY_LOCAL_MACHINE

reg ADD "HKLM\SOFTWARE\Policies\Google\Chrome"

::Enable
reg ADD "HKLM\SOFTWARE\Policies\Google\Update" /v AutoUpdateCheckPeriodMinutes /t REG_DWORD /d 1 /f /reg:64
reg ADD "HKLM\SOFTWARE\Policies\Google\Update" /v UpdateDefault /t REG_DWORD /d 1 /f /reg:64

::::::::::::::::::::::::::::::::Disable:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Update" /v UpdateDefault /t REG_DWORD /d 0 /f
::reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Update" /v AutoUpdateCheckPeriodMinutes /t REG_DWORD /d 0 /f
::reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Update" /v DisableAutoUpdateChecksCheckboxValue /t REG_DWORD /d 1 /f
::reg ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Update" /v Update{8A69D345-D564-463C-AFF1-A69D9E530F96} /t REG_DWORD /d 0 /f


::Policies for extensions should be written to the registry under :
:: HKLM\Software\Policies\Google\Chrome\3rdparty\extensions\gihmafigllmhbppdfjnfecimiohcljba\policy
:: https://www.chromium.org/administrators/configuring-policy-for-extensions
::Software\Policies\Google\Chrome\RendererCodeIntegrityEnabled


::[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Update]
::"UpdateDefault"=dword:00000000
::"AutoUpdateCheckPeriodMinutes"=dword:00000000
::"DisableAutoUpdateChecksCheckboxValue"=dword:00000000
::"Update{8A69D345-D564-463C-AFF1-A69D9E530F96}"=dword:00000000
::"Install{8A69D345-D564-463C-AFF1-A69D9E530F96}"=dword:00000000