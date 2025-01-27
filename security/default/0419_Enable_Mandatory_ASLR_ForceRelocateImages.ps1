# Refer to xxxxx

# Check SEHOP status
Write-Host "Current ASLR status and other config" 
Get-ProcessMitigation -System 
set-processmitigation -System -Enable ForceRelocateImages
Write-Host "New ASLR statu and other config"  