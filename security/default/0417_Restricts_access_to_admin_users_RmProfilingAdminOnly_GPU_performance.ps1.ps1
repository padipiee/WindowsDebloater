# Define the registry path and value name
# reference to the security "Restricting/Enabling Access to GPU Performance Counters
# example CVE-2018-6260 (NVIDIA)"

$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Services\nvlddmkm\Global\NVTweak"
$ValueName = "RmProfilingAdminOnly"
$DesiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path -Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
    Write-Output "Registry path '$RegistryPath' did not exist and has been created."
}

# Get the current value
$currentValue = Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction SilentlyContinue

if ($currentValue.$ValueName -eq $DesiredValue) {
    Write-Output "'$ValueName' is already set to $DesiredValue."
} else {
    # Set the value to 1
    Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $DesiredValue -Type DWord
    Write-Output "'$ValueName' was not set to $DesiredValue and has been updated."
}

# Verify the change
$updatedValue = Get-ItemProperty -Path $RegistryPath -Name $ValueName
Write-Output "Current value of '$ValueName': $($updatedValue.$ValueName)"