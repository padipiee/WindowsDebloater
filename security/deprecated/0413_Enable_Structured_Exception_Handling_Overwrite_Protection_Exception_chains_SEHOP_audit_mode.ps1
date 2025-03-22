# Refer to  #0407 and #0197_Enable_Structured_Exception_Handling_Overwrite_
#Protection_Exception_chains_SEHOP.ps1

# https://www.stigviewer.com/stig/windows_10/2019-01-04/finding/V-68849
# https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/override-mitigation-options-for-app-related-security-policies

# Function to set the registry value and display a message
Function Set-RegistryPolicy {
    param (
        [string]$Path,
        [string]$Key,
        [int]$Value
    )
    if (-not (Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
        Write-Host "Registry path '$Path' created."
    }
    $currentValue = (Get-ItemProperty -Path $Path -Name $Key -ErrorAction SilentlyContinue).$Key
    if ($currentValue -ne $Value) {
        Set-ItemProperty -Path $Path -Name $Key -Value $Value -PropertyType DWORD
        Write-Host "$Key set to $Value."
    } else {
        Write-Host "$Key is already set to $Value."
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