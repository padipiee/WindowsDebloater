
:: https://superuser.com/questions/645845/how-do-i-disable-google-chrome-silent-updates
:: HKLM=HKEY_LOCAL_MACHINE

::OMAHA
:: https://github.com/google/omaha/blob/master/omaha/base/constants.h
:: https://github.com/google/omaha/blob/master/doc/DeveloperSetupGuide.md

reg ADD "HKLM\SOFTWARE\Policies\Google\Chrome"

::::::Enable::::
:: Each application that wants to be kept up to date by Omaha needs to have a registry key under Software\​Wow6432Node\​Google\​Update\​Clients.
:: Chrome is registered there under the globally constant id {8A69D345-D564-463c-AFF1-A69D9E530F96}.
reg ADD "HKLM\SOFTWARE\Policies\Google\Update" /v AutoUpdateCheckPeriodMinutes /t REG_DWORD /d 1 /f /reg:64
reg ADD "HKLM\SOFTWARE\Policies\Google\Update" /v UpdateDefault /t REG_DWORD /d 1 /f /reg:64
::
reg ADD "HKLM\SOFTWARE\Wow6432Node\SOFTWARE\Policies\Google\Update" /v UpdateDefault /t REG_DWORD /d 1 /f
reg ADD "HKLM\SOFTWARE\Wow6432Node\SOFTWARE\Policies\Google\Update" /v AutoUpdateCheckPeriodMinutes /t REG_DWORD /d 1 /f
reg ADD "HKLM\SOFTWARE\Wow6432Node\SOFTWARE\Policies\Google\Update" /v DisableAutoUpdateChecksCheckboxValue /t REG_DWORD /d 0 /f
reg ADD "HKLM\SOFTWARE\Wow6432Node\SOFTWARE\Policies\Google\Update" /v Update{8A69D345-D564-463C-AFF1-A69D9E530F96} /t REG_DWORD /d 1 /f


::::::Disable::::::
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

rem | References:
rem | https://support.google.com/chrome/a/answer/6350036#Registry_Settings
rem | http://stackoverflow.com/a/28356336/1111895
rem | http://superuser.com/questions/645845/how-do-i-disable-google-chrome-silent-updates

echo Stopping and setting Google Update services to manual . . .
rem | don't disable the services as it seems to cause the policy settings to be ignored
rem | https://bugs.chromium.org/p/chromium/issues/detail?id=512627#c158
for %%i in ("gupdate" "gupdatem") do (
  "%windir%\system32\net.exe" stop %%~i>nul 2>&1
  "%windir%\system32\sc.exe" config %%~i start= demand>nul
  if errorlevel 1 pause
)

echo Stopping and disabling Google Update tasks . . .
rem | avoid overhead and help preventing the services configuration from being reset
for %%i in ("GoogleUpdateTaskMachineCore" "GoogleUpdateTaskMachineUA") do (
  "%windir%\system32\schtasks.exe" /end /TN "\%%~i">nul 2>&1
  "%windir%\system32\schtasks.exe" /change /disable /TN "\%%~i">nul
  if errorlevel 1 pause
)

echo Updating Google Update policy . . .
set TARGET_KEY=HKLM\SOFTWARE\Policies\Google\Update
for %%i in ("Update" "Install") do (
  rem | GUIDs mean "Google Chrome" and "Google Chrome binaries", which must be consistent
  rem | https://support.google.com/chrome/a/answer/3204698#auto-updates
  rem | Tip: to affect other Google Update packages, add "Default" to the list
  for %%j in ("{8A69D345-D564-463C-AFF1-A69D9E530F96}" "{4DC8B4CA-1BDA-483E-B5FA-D3C12E15B62D}") do (
    "%windir%\system32\reg.exe" add "%TARGET_KEY%" /v "%%~i%%~j" /t REG_DWORD /d 0 /f>nul
    if errorlevel 1 pause  
  )
)
rem | for machines *not* in a domain, this is limited to 77 hours (even when set to 0!)
rem | https://www.chromium.org/administrators/turning-off-auto-updates
"%windir%\system32\reg.exe" add "%TARGET_KEY%" /v "AutoUpdateCheckPeriodMinutes" /t REG_DWORD /d 0 /f>nul
if errorlevel 1 pause
rem | disable the auto-updater
rem | http://googlesystem.blogspot.pt/2009/05/customize-or-disable-google-update.html
"%windir%\system32\reg.exe" add "%TARGET_KEY%" /v "DisableAutoUpdateChecksCheckboxValue" /t REG_DWORD /d 1 /f>nul
if errorlevel 1 pause