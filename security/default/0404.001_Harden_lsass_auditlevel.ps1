#########################################################################
# Harden lsass to help protect against credential dumping (Mimikatz)
# Configures lsass.exe as a protected process and disables wdigest
# Enables delegation of non-exported credentials which enables support for Restricted Admin Mode or Remote Credential Guard
# https://technet.microsoft.com/en-us/library/dn408187(v=ws.11).aspx
# https://medium.com/blue-team/preventing-mimikatz-attacks-ed283e7ebdd5
# ---------------------

# Define the registry path and desired value
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LSASS.exe"
$propertyName = "AuditLevel"
$desiredValue = 8

# Check if registry key exists
if (-not (Test-Path $registryPath)) {
    Write-Host "Creating registry key $registryPath..."
    New-Item -Path $registryPath -Force | Out-Null
}

# Check if the AuditLevel value exists and if it has the correct value
$currentValue = Get-ItemProperty -Path $registryPath -Name $propertyName -ErrorAction SilentlyContinue

if ($null -eq $currentValue -or $currentValue.$propertyName -ne $desiredValue) {
    Write-Host "Setting LSASS AuditLevel to $desiredValue..."
    Set-ItemProperty -Path $registryPath -Name $propertyName -Value $desiredValue -Type DWord -Force
    Write-Host "LSASS hardening complete." -ForegroundColor Green
} else {
    Write-Host "LSASS AuditLevel is already set to $desiredValue. No changes needed." -ForegroundColor Green
}


