::   Turn off feature advertisement balloon notifications => Enabled
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v NoBalloonFeatureAdvertisements /t REG_DWORD /d 1 /f
reg query "HKCU\SOFTWARE\Policies\Microsoft\Windows\Explorer" 