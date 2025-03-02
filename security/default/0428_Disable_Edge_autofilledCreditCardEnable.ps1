# Define the registry path and value name

# Similar to Chrome, Edge also has a setting to enable or disable autofill for credit cards. 
#This script disables the autofill for credit cards in Edge by setting the "AutofillCreditCardEnabled" value to 0 in the registry.
#./security/default/0392_Disable_Chrome_AutofillCreditCardEnabled
#./security/default/0395_Disable_Brave_AutofillCreditCardEnabled.ps1

$registryPath = "HKCU:\Software\Policies\Microsoft\Edge"
$valueName = "AutofillCreditCardEnabled"

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Retrieve the current value of "AutofillCreditCardEnabled" and check if it's already 0
$currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue).$valueName
if ($currentValue -ne 0) {
    Set-ItemProperty -Path $registryPath -Name $valueName -Value 0
    Write-Host "Disabled credit card autofill."
} else {
    Write-Host "AutofillCreditCardEnabled is already disabled."
}