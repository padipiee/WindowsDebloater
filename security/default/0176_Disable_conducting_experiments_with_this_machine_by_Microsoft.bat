::@N@Disable conducting experiments with this machine by Microsoft@N@

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\System\AllowExperimentation" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\System" /v "AllowExperimentation" /t REG_DWORD /d 0 /f

::https://www.makeuseof.com/tag/disable-microsofts-settings-experiments-windows-10/