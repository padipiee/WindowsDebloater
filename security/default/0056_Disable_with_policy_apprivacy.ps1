Write-Output "[0056_Disable_with_policy_apprivacy] Disable with Policy AppPrivacy"

$targetValue = 2

# Function to check if registry key exists
function Test-RegistryKeyExists {
  param (
    [Parameter(Mandatory = $true)]
    [string]$Path
  )

  if (Test-Path -Path $Path) {
    return $true
  }
  else {
    return $false
  }
}

# Function to get registry value
function Get-RegistryValue {
  param (
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [Parameter(Mandatory = $true)]
    [string]$Name
  )

  $value = Get-ItemProperty -Path $Path -Name $Name | Select-Object -ExpandProperty $Name
  return $value
}

# Function to set registry value
function Set-RegistryValue {
  param (
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $true)]
    [string]$Value
  )

  Set-ItemProperty -Path $Path -Name $Name -Value $Value
}

# Test and set registry values
if (Test-RegistryKeyExists -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy") {
  $keys = @(
    "LetAppsAccessAccountInfo",
    "LetAppsAccessCalendar",
    "LetAppsAccessCallHistory",
    "LetAppsAccessContacts",
    "LetAppsAccessEmail",
    "LetAppsAccessLocation",
    "LetAppsAccessMessaging",
    "LetAppsAccessMotion",
    "LetAppsAccessNotifications",
    "LetAppsAccessRadios",
    "LetAppsAccessTrustedDevices",
    "LetAppsSyncWithDevices",
    "LetAppsAccessMicrophone",
    "LetAppsAccessCamera"
  )

  foreach ($key in $keys) {
    $currentValue = Get-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name $key

    if ($currentValue -ne $targetValue) {
      Set-RegistryValue -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name $key -Value $targetValue
      Write-Host "[0056_Disable_with_policy_apprivacy] Value for $key has been set to $targetValue"
    }
    else {
      Write-Host "[0056_Disable_with_policy_apprivacy] Value for $key is already set to $targetValue"
    }
  }
}
else {
  Write-Host "[0056_Disable_with_policy_apprivacy] Registry key HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy does not exist"
}

# Test and set registry value for SmartGlass
if (Test-RegistryKeyExists -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass") {
  $currentValue = Get-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" -Name "UserAuthPolicy"

  if ($currentValue -ne $targetValue) {
    Set-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" -Name "UserAuthPolicy" -Value $targetValue
    Write-Host "[0056_Disable_with_policy_apprivacy] Value for UserAuthPolicy has been set to $targetValue"
  }
  else {
    Write-Host "[0056_Disable_with_policy_apprivacy] Value for UserAuthPolicy is already set to $targetValue"
  }
}
else {
  Write-Host "[0056_Disable_with_policy_apprivacy] Registry key HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass does not exist"
}

# Test and set registry value for DeviceAccess
$shellExpPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\S-1-15-2-155514346-2573954481-755741238-1654018636-1233331829-3075935687-2861478708"
if (Test-RegistryKeyExists -Path $shellExpPath) {
  $currentValue = Get-RegistryValue -Path "$shellExpPath\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" -Name "Value"

  if ($currentValue -ne "Deny") {
    Set-RegistryValue -Path "$shellExpPath\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" -Name "Value" -Value "Deny"
    Write-Host "[0056_Disable_with_policy_apprivacy] Value for DeviceAccess has been set to Deny"
  }
  else {
    Write-Host "[0056_Disable_with_policy_apprivacy] Value for DeviceAccess is already set to Deny"
  }
}
else {
  Write-Host "[0056_Disable_with_policy_apprivacy] Registry key $shellExpPath does not exist"
}
