<#
.SYNOPSIS
Checks the status of Data Execution Prevention (DEP) on the current operating system.
0: DEP is disabled for all processes.
1: DEP is enabled for all processes.
2: DEP is enabled for only Windows system components and services. (Default)
3: DEP is enabled for all processes, but some exceptions are allowed.

.DESCRIPTION
This script uses the `wmic` command to retrieve the DataExecutionPrevention_SupportPolicy property of the OS class, which indicates the status of Data Execution Prevention (DEP) on the current operating system.

.PARAMETER None

.EXAMPLE
Returns the current status of Data Execution Prevention (DEP) on the operating system.

#>

wmic OS Get DataExecutionPrevention_SupportPolicy
