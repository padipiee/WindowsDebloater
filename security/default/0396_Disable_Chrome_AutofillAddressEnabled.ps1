# Set the path to the Chrome policy file
$ChromePolicyPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"

# Ensure the Chrome policy path exists
If (-Not (Test-Path $ChromePolicyPath)) {
    New-Item -Path $ChromePolicyPath -Force
}

# Function to set the property and display a message
Function Set-ChromePolicy {
    param (
        [string]$Key,
        [int]$Value
    )
    If ($null -ne  (Get-ItemProperty -Path $ChromePolicyPath -Name $Key -ErrorAction SilentlyContinue) ) {
        Set-ItemProperty -Path $ChromePolicyPath -Name $Key -Value $Value
        Write-Host "[0396_Disable_Chrome_AutofillAddressEnabled] The key '$Key' was already set. It has been reconfirmed as disabled."
    } else {
        New-ItemProperty -Path $ChromePolicyPath -Name $Key -Value $Value -PropertyType DWORD
        Write-Host "[0396_Disable_Chrome_AutofillAddressEnabled] The key '$Key' did not exist. It has been created and set as disabled."
    }
}


# Disable 'Allow sites to check if you have payment methods saved'
Set-ChromePolicy -Key "AutofillAddressEnabled" -Value 0

# Output the current settings
Write-Host "[0396_Disable_Chrome_AutofillAddressEnabled] Current config is so : "
Get-ItemProperty -Path $ChromePolicyPath

