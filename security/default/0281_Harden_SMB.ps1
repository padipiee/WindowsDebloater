# Disable SMB Server - Completely disables file and printer sharing, but leaves the system able to connect to another SMB server as a client
# Note: Do not run this if you plan to use Docker and Shared Drives (as it uses SMB internally),
# see https://github.com/Disassembler0/Win10-Initial-Setup-Script/
#https://learn.microsoft.com/en-us/windows-server/storage/file-server/troubleshoot/detect-enable-and-disable-smbv1-v2-v3?tabs=server

Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
Write-Output "Disable SMB 1"
Set-SmbServerConfiguration -EnableSMB2Protocol $true -Force
Write-Output "Enabling SMB 2  EnableSMB2Protocolonly"
# Enable SMB Encryption - using force to confirm the action
Set-SmbServerConfiguration -EncryptData $true -force
Write-Output "Enabling SMB EncryptData "

Get-SmbServerConfiguration


Write-Output "Get WindowsOptionalFeature FeatureName SMB1Protocol : "
Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

Write-Output "Get-SmbServerConfiguration  EnableSMB2Protocol: "
Get-SmbServerConfiguration | Select EnableSMB2Protocol