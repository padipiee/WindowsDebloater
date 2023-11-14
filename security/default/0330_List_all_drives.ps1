<#
.SYNOPSIS
Lists all drives in the file system.

.DESCRIPTION
This script lists all drives in the file system using the Get-PSDrive cmdlet and filtering the results to only show drives with the provider "Microsoft.PowerShell.Core\FileSystem". The output includes the name and root of each drive.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
PS C:\> .\0330_List_all_drives.ps1
Lists all drives in the file system.

.OUTPUTS
The output of this script is a table with the name and root of each drive.

#>
Get-PSDrive | where {$_.Provider -like "Microsoft.PowerShell.Core\FileSystem"}| ft Name,Root