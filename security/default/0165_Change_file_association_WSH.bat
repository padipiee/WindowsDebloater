
:: Change file associations to protect against common attacks
:: Note that if you legitimately use these extensions, like .bat, you will now need to execute them manually from cmd or powershell
:: ---------------------
ftype WSHFile="%SystemRoot%\system32\NOTEPAD.EXE" "%1"