<#
.SYNOPSIS
Lists all the files with .bat, .ps1, and .py extensions in the current directory and its subdirectories, excluding .reg files.

.DESCRIPTION
This command uses Get-ChildItem cmdlet to retrieve all the files with .bat, .ps1, and .py extensions in the current directory and its subdirectories, excluding .reg files. The output is sorted by name and displayed in a table format.

.PARAMETER Path
Specifies the path to the directory to search for files. If not specified, the current directory is used.

.EXAMPLE
PS C:\> .\listneat.ps1
Lists all the files with .bat, .ps1, and .py extensions in the current directory and its subdirectories, excluding .reg files.

PS C:\> .\listneat.ps1 -Path "D:\Scripts"
Lists all the files with .bat, .ps1, and .py extensions in the "D:\Scripts" directory and its subdirectories, excluding .reg files.

.INPUTS
None.

.OUTPUTS
System.IO.FileInfo.

.NOTES
Author: Unknown
Date: Unknown
#>
Get-ChildItem -Path . -Recurse -File -Exclude *.reg -Include *.bat,*.ps1,*.py| Where-Object { $_.Attributes -ne "Directory"}  | where { $_.GetType().Name -eq "FileInfo" } | Sort-Object Name | Format-Table Name, Fullname -auto


