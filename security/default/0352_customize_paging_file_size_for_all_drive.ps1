<#
.SYNOPSIS
Customize paging file size for all drives.

.DESCRIPTION
This script retrieves the instance of the Win32_PageFileSetting class and sets the initial and maximum size of the paging file for all drives

.PARAMETER None

.EXAMPLE
.\0352_customize_paging_file_size_for_all_drive.ps1

This example customizes the paging file size for all drives.

#>
# Get the instance of the Win32_PageFileSetting class
$pagefile = Get-WmiObject -Query "SELECT * FROM Win32_PageFileSetting"

# Set the initial and maximum size of the paging file in MB
$pagefile.InitialSize = 2500  
$pagefile.MaximumSize = 3000  

# Apply the changes
$pagefile | Set-WmiInstance