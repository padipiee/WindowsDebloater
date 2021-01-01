::@N@Add Legal Notice to startup@N@

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v legalnoticecaption /t REG_SZ /d "Legal Notice" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v legalnoticetext  /t REG_SZ /d "Only the UNIQUE owner of this PC is authorized to access it. Trespassers will be in critical situation and prosecuted" /f
::[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
::"legalnoticecaption"="Type Your Title Here"
::"legalnoticetext"="Type Your Text Here"