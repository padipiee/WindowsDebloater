# Disable keylogger InputPersonalization

<#
.SYNOPSIS
This script disables the keylogger InputPersonalization by modifying registry values.

.DESCRIPTION
The script contains a function called Test-And-Set-RegistryItem, which tests and sets the value of a registry item.
It then calls the Test-And-Set-RegistryItem function multiple times to disable various keylogger settings.

.PARAMETER Path
The registry path where the item is located.

.PARAMETER Name
The name of the registry item.

.PARAMETER Value
The value to set for the registry item.

.NOTES
Author: [Author Name]
Date: [Date]
Version: [Version]

.EXAMPLE
Test-And-Set-RegistryItem -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1
# Tests and sets the value of the registry item "RestrictImplicitInkCollection" to 1 in the specified path.

#>

# Test and set registry item value
function Test-And-Set-RegistryItem {
  param (
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $true)]
    [string]$Value
  )

  if (Test-Path -Path $Path) {
    $CurrentValue = Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $Name

    if ($CurrentValue -ne $Value) {
      Set-ItemProperty -Path $Path -Name $Name -Value $Value
      Write-Host "[0021_Disable_keylogger_InputPersonalization] Value changed for $Path\$Name to $Value"
    }
    else {
      Write-Host "[0021_Disable_keylogger_InputPersonalization] No change for $Path\$Name with value $Value"
    }
  }
  else {
    Write-Host "[0021_Disable_keylogger_InputPersonalization] Item does not exist: $Path"
  }
}

# Disable keylogger InputPersonalization
$testResults = @(
  (Test-And-Set-RegistryItem -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1),
  (Test-And-Set-RegistryItem -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1),
  (Test-And-Set-RegistryItem -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Value 1),
  (Test-And-Set-RegistryItem -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Value 1),
  (Test-And-Set-RegistryItem -Path "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Value 0),
  (Test-And-Set-RegistryItem -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC" -Name "PreventHandwritingDataSharing" -Value 1),
  (Test-And-Set-RegistryItem -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" -Name "PreventHandwritingErrorReports" -Value 1),
  (Test-And-Set-RegistryItem -Path "HKCU:\Software\Policies\Microsoft\Windows\HandwritingErrorReports" -Name "PreventHandwritingErrorReports" -Value 1),
  (Test-And-Set-RegistryItem -Path "HKCU:\Software\Policies\Microsoft\Windows\TabletPC" -Name "PreventHandwritingDataSharing" -Value 1),
  (Test-And-Set-RegistryItem -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Value 0)
)

$testResults | ForEach-Object {
  Write-Host "[0021_Disable_keylogger_InputPersonalization] $_"
}
