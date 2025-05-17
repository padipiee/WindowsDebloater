<#
.SYNOPSIS
    Checks the IPv6 configuration status on the local machine.
.DESCRIPTION
    This script performs several checks to determine the status of IPv6:
    1. Checks the 'DisabledComponents' registry value which can globally disable or modify IPv6 behavior.
    2. Checks IPv6 bindings on all network adapters.
    3. Lists active IPv6 network interfaces.
    It provides a summary of the findings.
.NOTES
    Requires administrative privileges for some checks (e.g., reading certain registry keys accurately or getting all adapter details).
#>

Write-Host "--- Comprehensive IPv6 Status Check ---" -ForegroundColor Yellow

# 1. Check DisabledComponents Registry Value
Write-Host "`n[1] Checking 'DisabledComponents' Registry Value..."
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters"
$regValueName = "DisabledComponents"
$disabledComponentsValue = Get-ItemProperty -Path $regPath -Name $regValueName -ErrorAction SilentlyContinue

if ($disabledComponentsValue -ne $null) {
    $val = $disabledComponentsValue.$regValueName
    Write-Host "  Registry Key: $regPath"
    Write-Host "  Value Name  : $regValueName"
    Write-Host "  Current Value: 0x$($val.ToString('X2')) ($val)"

    if ($val -eq 0xFF) {
        Write-Host "  Status: IPv6 is configured to be globally DISABLED." -ForegroundColor Red
    } elseif ($val -eq 0x00) {
        Write-Host "  Status: IPv6 is configured to be ENABLED (default behavior)." -ForegroundColor Green
    } elseif (($val -band 0x01) -ne 0) {
        Write-Host "  Status: IPv6 tunnel interfaces are disabled." -ForegroundColor Magenta
    } elseif (($val -band 0x10) -ne 0) {
        Write-Host "  Status: IPv6 is preferred over IPv4." -ForegroundColor Cyan
    } else {
        Write-Host "  Status: Custom IPv6 configuration (Value: $val). Refer to Microsoft documentation for DisabledComponents." -ForegroundColor Magenta
    }
} else {
    Write-Host "  '$regValueName' not found under '$regPath'."
    Write-Host "  Status: IPv6 is likely ENABLED (default configuration)." -ForegroundColor Green
}

# 2. Check IPv6 Bindings on Network Adapters
Write-Host "`n[2] Checking IPv6 Bindings on Network Adapters..."
Write-Host "  Testing for 'Internet Protocol Version 6 (TCP/IPv6)' (ComponentID: ms_tcpip6) binding:" -ForegroundColor Cyan
$adapters = Get-NetAdapter -ErrorAction SilentlyContinue
if ($adapters) {
    foreach ($adapter in $adapters) {
        $adapterName = $adapter.Name
        $binding = Get-NetAdapterBinding -Name $adapterName -ComponentID ms_tcpip6 -ErrorAction SilentlyContinue
        if ($binding) {
            $status = if ($binding.Enabled) { "Enabled" } else { "Disabled" }
            $color = if ($binding.Enabled) { "Green" } else { "Red" }
            Write-Host ("  Adapter: '{0}' - IPv6 (ms_tcpip6) Binding: {1}" -f $adapterName, $status) -ForegroundColor $color
            if ($binding.Enabled) {
                Write-Host ("    To Disable: Disable-NetAdapterBinding -Name ""{0}"" -ComponentID ms_tcpip6" -f $adapterName) -ForegroundColor Gray
            } else {
                Write-Host ("    To Enable : Enable-NetAdapterBinding -Name ""{0}"" -ComponentID ms_tcpip6" -f $adapterName) -ForegroundColor Gray
            }
        } else {
            Write-Host "  Adapter: '{0}' - Could not retrieve IPv6 (ms_tcpip6) binding information." -f $adapterName -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "  Could not retrieve network adapter information." -ForegroundColor Red
}

# 3. List Active IPv6 Network Interfaces
Write-Host "`n[3] Checking Active IPv6 Network Interfaces..."
$ipv6Interfaces = Get-NetIPInterface -AddressFamily IPv6 -ErrorAction SilentlyContinue
if ($ipv6Interfaces.Count -gt 0) {
    Write-Host "  Found active IPv6 interfaces:" -ForegroundColor Green
    $ipv6Interfaces | ForEach-Object {
        Write-Host ("    IfIndex: {0}, InterfaceAlias: {1}, AddressFamily: IPv6, Forwarding: {2}, Advertising: {3}" -f $_.InterfaceIndex, $_.InterfaceAlias, $_.Forwarding, $_.Advertising)
        $ipAddresses = Get-NetIPAddress -InterfaceIndex $_.InterfaceIndex -AddressFamily IPv6 -ErrorAction SilentlyContinue
        if ($ipAddresses) {
            $ipAddresses | ForEach-Object {
                Write-Host ("      IPAddress: {0}, PrefixLength: {1}, Type: {2}" -f $_.IPAddress, $_.PrefixLength, $_.Type)
            }
        }
    }
} else {
    Write-Host "  No active IPv6 network interfaces found." -ForegroundColor Red
}

# Summary
Write-Host "`n--- Summary ---"
if ($disabledComponentsValue -ne $null -and $disabledComponentsValue.$regValueName -eq 0xFF) {
    Write-Host "IPv6 appears to be globally disabled via the 'DisabledComponents' registry setting." -ForegroundColor Red
} elseif ($ipv6Interfaces.Count -gt 0) {
    Write-Host "IPv6 appears to be active on one or more network interfaces." -ForegroundColor Green
    Write-Host "Review adapter bindings and 'DisabledComponents' for a complete picture."
} else {
    Write-Host "IPv6 might be disabled or not configured on active network interfaces." -ForegroundColor Yellow
    Write-Host "Check 'DisabledComponents' registry value and adapter bindings for confirmation."
}
Write-Host "For detailed interpretation of 'DisabledComponents', see Microsoft's guidance on disabling IPv6."

Write-Host "`n--- Check Complete ---" -ForegroundColor Yellow