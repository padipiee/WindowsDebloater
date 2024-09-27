# Refer to  #0407 and #0197_Enable_Structured_Exception_Handling_Overwrite_Protection_Exception_chains_SEHOP.ps1

# https://www.stigviewer.com/stig/windows_10/2019-01-04/finding/V-68849
# https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/override-mitigation-options-for-app-related-security-policies

# Function to set the registry value and display a message
Function Set-RegistryPolicy {
    param (
        [string]$Path,
        [string]$Key,
        [int]$Value
    )
    # Ensure the registry path exists
    If (-Not (Test-Path $Path)) {
        # Create the registry path if it does not exist
        New-Item -Path $Path -Force | Out-Null
        Write-Host "Registry path '$Path' did not exist. It has been created."
    }

    # Check if the registry key exists
    $existingKey = Get-ItemProperty -Path $Path -Name $Key -ErrorAction SilentlyContinue
    If ($null -ne $existingKey) {
        # If it exists, set the value
        Set-ItemProperty -Path $Path -Name $Key -Value $Value
        Write-Host "The key '$Key' was already set. It has been reconfirmed with the new value."
    } else {
        # If it does not exist, create it and set the value
        New-ItemProperty -Path $Path -Name $Key -Value $Value -PropertyType DWORD | Out-Null
        Write-Host "The key '$Key' did not exist. It has been created and set with the value."
    }
}

# Define the registry path for SEHOP
$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\kernel"
$PropertyName = "DisableExceptionChainValidation"
$AuditValue = 2  # 0x00000002 for Audit mode

# Use the function to set 'DisableExceptionChainValidation' to 2 (Audit mode)
Set-RegistryPolicy -Path $RegistryPath -Key $PropertyName -Value $AuditValue

# Verify the change
try {
    $propertyValue = Get-ItemProperty -Path $RegistryPath -Name $PropertyName -ErrorAction Stop
    Write-Host "Current value of ${PropertyName}: $($propertyValue.$PropertyName)"
} catch [System.Management.Automation.ItemNotFoundException] {
    Write-Host "Property ${PropertyName} does not exist."
} catch {
    Write-Host "Error: Unable to retrieve the property ${PropertyName}."
}

# Check SEHOP status
Write-Host "Current SEHOP status:"
Get-ProcessMitigation -System | Select-Object -ExpandProperty SEHOP