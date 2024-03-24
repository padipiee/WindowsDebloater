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
    If ((Get-ItemProperty -Path $ChromePolicyPath -Name $Key -ErrorAction SilentlyContinue) -ne $null) {
        Set-ItemProperty -Path $ChromePolicyPath -Name $Key -Value $Value
        Write-Host "[0392_Disable_Chrome_AutofillCreditCardEnabled] The key '$Key' was already set. It has been reconfirmed as disabled."
    } else {
        New-ItemProperty -Path $ChromePolicyPath -Name $Key -Value $Value -PropertyType DWORD
        Write-Host "[0392_Disable_Chrome_AutofillCreditCardEnabled] The key '$Key' did not exist. It has been created and set as disabled."
    }
}

# Disable 'Save and fill payment methods'
Set-ChromePolicy -Key "AutofillCreditCardEnabled" -Value 0
#"AutofillCreditCardEnabled"=dword:00000000

# Disable 'Allow sites to check if you have payment methods saved'
Set-ChromePolicy -Key "AutofillCreditCardSigninPromoEnabled" -Value 0

# Output the current settings
Write-Host "[0392_Disable_Chrome_AutofillCreditCardEnabled] Current config is so : "
Get-ItemProperty -Path $ChromePolicyPath



# Output completion message
# Write-Host "[0392_Disable_Chrome_AutofillCreditCardEnabled] Chrome autofill for Credit Card have been disabled, along with AutofillCreditCardSigninPromoEnabled"
