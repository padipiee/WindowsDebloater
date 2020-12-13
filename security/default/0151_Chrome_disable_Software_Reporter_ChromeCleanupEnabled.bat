:: Disable Chrome Software Reporter Tool using Chrome Policies

reg add "HKLM\SOFTWARE\Policies\Google\Chrome" /v ChromeCleanupEnabled /t REG_DWORD /d 0

::Enter 0 for disabling the tool. Enter 1 to enable the tool.
::https://www.itechtics.com/disable-software-reporter-tool/
