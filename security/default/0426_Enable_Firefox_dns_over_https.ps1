function ConfigureDNSOverHTTPS {
    $regPath = "HKLM:\SOFTWARE\Policies\Mozilla\Firefox"
    $dnsValue = (Get-ItemProperty -Path $regPath -Name "DNSOverHTTPS" -ErrorAction SilentlyContinue).DNSOverHTTPS
    if ($dnsValue -ne 2) {
        Set-ItemProperty -Path $regPath -Name "DNSOverHTTPS" -Value 2
        Write-Host "Enabled DNSOverHTTPS."
    } else {
        Write-Host "DNSOverHTTPS is already enabled."
    }
    $providerValue = (Get-ItemProperty -Path $regPath -Name "DNSOverHTTPS.ProviderURL" -ErrorAction SilentlyContinue)."DNSOverHTTPS.ProviderURL"
    if ($providerValue -ne "https://protected.canadianshield.cira.ca/dns-query") {
        Set-ItemProperty -Path $regPath -Name "DNSOverHTTPS.ProviderURL" -Value "https://protected.canadianshield.cira.ca/dns-query"
        #Set-ItemProperty -Path $regPath -Name "DNSOverHTTPS.ProviderURL" -Value "https://cloudflare-dns.com/dns-query"
        Write-Host "Provider set to CIRA."
    } else {
        Write-Host "DNSOverHTTPS.ProviderURL is already CIRA (protected.cira.ca)"
    }
    
}
ConfigureDNSOverHTTPS


