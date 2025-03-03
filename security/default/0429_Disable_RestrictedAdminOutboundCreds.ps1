#  Harden lsass to help protect against credential dumping
$currentValue = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "DisableRestrictedAdminOutboundCreds" -ErrorAction SilentlyContinue)."DisableRestrictedAdminOutboundCreds"
if ($currentValue -ne 1) {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "DisableRestrictedAdminOutboundCreds" -Type DWord -Value 1
    Write-Host "DisableRestrictedAdminOutboundCreds set to 1."
} else {
    Write-Host "DisableRestrictedAdminOutboundCreds is already 1."
}