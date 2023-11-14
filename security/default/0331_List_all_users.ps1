<#
.SYNOPSIS
Lists all local users and their last logon time, as well as all user profiles on the system.

.DESCRIPTION
This script retrieves a list of all local users on the system, along with their enabled status and last logon time. It also retrieves a list of all user profiles on the system.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
./0331_List_all_users.ps1
#>
Get-LocalUser | ft Name,Enabled,LastLogon
Get-ChildItem C:\Users -Force | select Name