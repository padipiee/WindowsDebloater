<#
.SYNOPSIS
Checks the BitLocker key identifier for the C: drive.

.DESCRIPTION
This script uses the 'manage-bde' command to retrieve the BitLocker key identifier for the C: drive.

.PARAMETER None

.EXAMPLE
PS> .\0347_check_bilocker.ps1
  Retrieves the BitLocker key identifier for the C: drive.

#>

manage-bde -protectors -get C:
# check  BitLocker key identifier

manage-bde -protectors -get C: