# Refer to  0197_Enable_Structured_Exception_Handling_Overwrite_Protection_Exception_chains_SEHOP.ps1

# https://www.stigviewer.com/stig/windows_10/2019-01-04/finding/V-68849
# https://learn.microsoft.com/en-us/windows/security/operating-system-security/device-management/override-mitigation-options-for-app-related-security-policies

# Script to enable Structured Exception Handling Overwrite Protection (SEHOP)
Write-Host "`n[AUDIT] Checking current SEHOP settings..." -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "BEFORE CHANGE:" -ForegroundColor Yellow
$beforeState = Get-ProcessMitigation -System | Select-Object -ExpandProperty SEHOP
$beforeState | Format-List

# Add explanation about NOTSET value
Write-Host "`nNOTE: The 'Audit' value showing as 'NOTSET' is normal and means the audit policy" -ForegroundColor Gray
Write-Host "for this protection is not explicitly set. This doesn't affect the protection itself." -ForegroundColor Gray
Write-Host "The important setting is 'Enable' which should be 'ON' after applying this script." -ForegroundColor Gray

try {
    Write-Host "`n[ACTION] Enabling SEHOP system-wide..." -ForegroundColor Cyan
    Set-ProcessMitigation -System -Enable SEHOP
    Write-Host "SEHOP successfully enabled." -ForegroundColor Green
}
catch {
    Write-Host "ERROR: Failed to enable SEHOP: $_" -ForegroundColor Red
    exit 1
}

Write-Host "`n[AUDIT] Verifying SEHOP settings..." -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host "AFTER CHANGE:" -ForegroundColor Yellow
$afterState = Get-ProcessMitigation -System | Select-Object -ExpandProperty SEHOP
$afterState | Format-List

# Improved verification that focuses on the Enable property
if ($afterState.Enable -eq "ON") {
    Write-Host "`n[SUCCESS] SEHOP has been successfully enabled (Enable = ON)." -ForegroundColor Green
    Write-Host "The 'Audit' property showing as 'NOTSET' is expected and does not affect protection." -ForegroundColor Green
}
else {
    Write-Host "`n[WARNING] SEHOP does not appear to be enabled properly. Enable = $($afterState.Enable)" -ForegroundColor Red
    Write-Host "Please check the settings manually." -ForegroundColor Red
}


