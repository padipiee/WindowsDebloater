New-Item -Path HKLM:\SOFTWARE\Policies\Google -name Update -value 1 -Force
New-Item -Path HKLM:\SOFTWARE\Wow6432Node\Policies\Google -name Update -value 1 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Google\Update -type dword -name AutoUpdateCheckPeriodMinutes -value 1 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Google\Update -type dword -name DisableAutoUpdateChecksCheckboxValue -value 0 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Google\Update -type dword -name "Update{8A69D345-D564-463C-AFF1-A69D9E530F96}" -value 1 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Google\Update -type dword -name UpdateDefault -value 1 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Policies\Google\Update -type dword -name AutoUpdateCheckPeriodMinutes -value 1 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Policies\Google\Update -type dword -name DisableAutoUpdateChecksCheckboxValue -value 0 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Policies\Google\Update -type dword -name "Update{8A69D345-D564-463C-AFF1-A69D9E530F96}" -value 1 -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Policies\Google\Update -type dword -name UpdateDefault -value 1 -Force
Start-Service gupdate
Start-Service gupdatem
Log "Attempted to start Google update services(s)."
 

