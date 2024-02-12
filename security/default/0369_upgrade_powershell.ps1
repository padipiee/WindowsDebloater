
<#
.SYNOPSIS
This script searches for the Microsoft.PowerShell package using the winget command and installs it if not already installed.

.DESCRIPTION
The script uses the winget command to search for the Microsoft.PowerShell package. If the package is found, it is installed using the winget install command. If the package is already installed, no action is taken.

.PARAMETER None
This script does not accept any parameters.

.EXAMPLE
.\0369_block_upgrade_powershell.ps1
This example runs the script and searches for the Microsoft.PowerShell package using the winget command. If the package is not installed, it is installed using the winget install command.

.NOTES
Author: Your Name
Date: Current Date
Version: 1.0
#>


$package = "Microsoft.PowerShell"

$package = "Microsoft.PowerShell"

try {
    $installedVersion = (winget list --name $package --exact | Select-String -Pattern "\d+(\.\d+)*" -AllMatches).Matches.Value | Sort-Object -Descending | Select-Object -First 1
    $latestVersion = (winget search $package --exact | Select-String -Pattern "\d+(\.\d+)*" -AllMatches).Matches.Value | Sort-Object -Descending | Select-Object -First 1
} catch {
    Write-Host "[0369_upgrade_powershell] An error occurred while retrieving the version information for $package."
    exit
}

if ($installedVersion -lt $latestVersion) {
    Write-Host "[0369_upgrade_powershell]  A newer version of $package is available. Installing..."
    winget install --id $package --source winget
} else {
    Write-Host "[0369_upgrade_powershell] No newer version of $package is available."
}