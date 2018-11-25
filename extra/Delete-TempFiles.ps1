#Adapted From https://github.com/Fifteen15Studios/PowerShell/blob/master/SCCM/Delete-TempFiles.ps1

#Requires -runasadministrator
#
# Deletes files from various locations used for temporary storage

$tempFolders = @( “C:\Windows\Temp\*”, “C:\Documents and Settings\*\Local Settings\temp\*”, “C:\Users\*\Appdata\Local\Temp\*”)

Remove-Item $tempFolders -recurse -force -ErrorAction SilentlyContinue