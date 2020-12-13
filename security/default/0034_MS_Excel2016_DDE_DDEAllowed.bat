
REM https://www.peerlyst.com/posts/windows-dde-registry-tweaks-roger-barnett?utm_source=linkedin&utm_medium=Application_Share&utm_content=peerlyst_post&utm_campaign=peerlyst_shared_post

echo  Disable Excel 2016  DDE links activation


REM Registry Path: HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Options
REM Value: DontUpdateLinks
REM Dword: 00000001
reg add "HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Options" /v "DontUpdateLinks" /t REG_DWORD /d 1 /f  

REM Registry Path: HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Options
REM Value: DDEAllowed
REM Dword: 00000000
reg add "HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Options" /v "DDEAllowed" /t REG_DWORD /d 0 /f  

