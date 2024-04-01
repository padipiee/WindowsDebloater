<#
.SYNOPSIS
This script disables the save and fill of address functionality in the Brave browser by modifying the registry settings.

.DESCRIPTION
The script checks if the registry key for Brave exists and creates it if it doesn't.

.PARAMETER None

.EXAMPLE
Runs the script to disable save and fill functionality in Brave.

.NOTES
Author: [Author Name]
Date: [Date]
Version: [Version]
#>

# Define the registry path
$BravePolicyPath = "HKCU:\Software\Policies\BraveSoftware\Brave"


Function Set-BravePolicy {
    param (
        [string]$Key,
        [int]$Value
    )
    If ($null -ne  (Get-ItemProperty -Path $BravePolicyPath -Name $Key -ErrorAction SilentlyContinue) ) {
        Set-ItemProperty -Path $BravePolicyPath -Name $Key -Value $Value
        Write-Host "[0395_Disable_Brave_AutofillCreditCardEnabled]  The key '$Key' was already set. It has been reconfirmed as disabled."
    } else {
        New-ItemProperty -Path $BravePolicyPath -Name $Key -Value $Value -PropertyType DWORD
        Write-Host "[0395_Disable_Brave_AutofillCreditCardEnabled] The key '$Key' did not exist. It has been created and set as disabled."
    }
}

Set-BravePolicy -Key "AutofillCreditCardEnabled" -Value 0

# Output the current settings
Write-Host "[0395_Disable_Brave_AutofillCreditCardEnabled] Current config is so : "
Get-ItemProperty -Path $BravePolicyPath

