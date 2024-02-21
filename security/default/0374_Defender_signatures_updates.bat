REM This batch file updates the signatures of Windows Defender.
REM It changes the current directory to the Windows Defender installation directory
REM and then runs the MpCmdRun.exe utility with the -SignatureUpdate parameter.
REM This triggers the update process for Windows Defender signatures.

cd %ProgramFiles%\Windows Defender
MpCmdRun.exe -SignatureUpdate