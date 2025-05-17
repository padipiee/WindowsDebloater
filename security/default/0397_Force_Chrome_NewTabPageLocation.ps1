# Check for admin rights
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Host "[0397_Force_Chrome_NewTabPageLocation] This script requires administrator privileges. Please run as administrator." -ForegroundColor Red
    exit 1
}

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
        [string]$Value
    )
    Try {
        # Attempt to update the property if it exists
        Set-ItemProperty -Path $ChromePolicyPath -Name $Key -Value $Value
        Write-Host "[0397_Force_Chrome_NewTabPageLocation] The key '$Key' was existing or been updated with the value '$Value'."
    }
    Catch {
        # If the property does not exist, create it as a String
        New-ItemProperty -Path $ChromePolicyPath -Name $Key -Value $Value -PropertyType String -ErrorAction Stop
        Write-Host "[0397_Force_Chrome_NewTabPageLocation] The key '$Key' did not exist. It has been created with the value '$Value'."
    }
}

# Set the policy
Set-ChromePolicy -Key "NewTabPageLocation" -Value "https://www.startpage.com/"

# Enable the setting to use a custom New Tab Page
Set-ChromePolicy -Key "NewTabPageEnabled" -Value "true"

# Output the current settings
Write-Host "[0397_Force_Chrome_NewTabPageLocation] Current config is so : "
Get-ItemProperty -Path $ChromePolicyPath
