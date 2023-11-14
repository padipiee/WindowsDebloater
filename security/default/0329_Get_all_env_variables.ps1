<#
.SYNOPSIS
Gets all environment variables and their values.

.DESCRIPTION
This command uses the Get-ChildItem cmdlet to retrieve all environment variables and their values, and then formats the output as a table with columns for the variable name and value.

.EXAMPLE
Get-ChildItem Env: | ft Key,Value
#>
Get-ChildItem Env: | ft Key,Value