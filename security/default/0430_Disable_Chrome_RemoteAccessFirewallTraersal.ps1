$registryPath = "HKLM:\Software\Policies\Google\Chrome"
$valueName = "RemoteAccessHostFirewallTraversal"
$desiredValue = 0

# Create path if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
    Write-Host "Created registry path: $registryPath"
}

# Get current value
$currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue).$valueName

# Set the value if needed
if ($currentValue -ne $desiredValue) {
    Set-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "Chrome RemoteAccessHostFirewallTraversal disabled."
} else {
    Write-Host "Chrome RemoteAccessHostFirewallTraversal is already disabled."
}
