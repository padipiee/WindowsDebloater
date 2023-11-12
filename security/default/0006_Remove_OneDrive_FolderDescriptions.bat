
:: Caution to remove this one ! could be related to 'Can't Find the Specified File' //Can't rename any folder in my PC   - Error When Rename/Move Folder in Windows 10/8/7
:: ! see 0006R
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{A52BBA46-E9E1-435f-B3D9-28DAA648C0F6}" 
if not errorlevel 1 (
	reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{A52BBA46-E9E1-435f-B3D9-28DAA648C0F6}" /f
	echo 0006 - Removing the OneDrive FolderDescriptions
)