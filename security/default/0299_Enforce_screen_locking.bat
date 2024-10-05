


@REM powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 300
@REM powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 300
@REM powercfg.exe /setactive SCHEME_CURRENT

@REM #cmd 
@REM REG ADD 'HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\7516b95f-f776-4464-8c53-06167f40cc99\8EC4B3A5-6868-48c2-BE75-4F3044BE88A7' /v Attributes /t REG_DWORD /d 00000002 /