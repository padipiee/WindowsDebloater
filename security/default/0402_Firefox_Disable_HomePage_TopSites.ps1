# PowerShell script to disable Top Sites (top shortcuts) on the Firefox homepage via Windows Registry

# Define the registry path for Firefox policies
$registryPath = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox"
$title = "[0402_Firefox_Disable_HomePage_TopSites]"

# Ensure the Firefox policy path exists
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Created Firefox policy registry path."
}

# Initialize variable to check if DisableTopSites exists
$disableTopSitesExists = $false
$disableTopSitesValue = $null

# Check if the DisableTopSites policy already exists
try {
    $disableTopSitesValue = Get-ItemPropertyValue -Path $registryPath -Name "DisableTopSites" -ErrorAction Stop
    $disableTopSitesExists = $true
} catch {
    # Catch block left intentionally empty
}

if (-not $disableTopSitesExists) {
    # The DisableTopSites policy does not exist, create it and set its value to true (1)
    New-ItemProperty -Path $registryPath -Name "DisableTopSites" -Value 1 -PropertyType DWord -Force | Out-Null
    Write-Host "$title The DisableTopSites policy has been created and top shortcuts will be disabled in Firefox."
} elseif ($disableTopSitesValue -eq 1) {
    # The DisableTopSites policy already exists and is set to the correct value
    Write-Host "$title The DisableTopSites policy already exists and is correctly set to disable top shortcuts in Firefox. No changes made."
} else {
    # The DisableTopSites policy exists but is not set to the correct value, update it
    Set-ItemProperty -Path $registryPath -Name "DisableTopSites" -Value 1
    Write-Host "$title The DisableTopSites policy has been updated to disable top shortcuts in Firefox."
}
