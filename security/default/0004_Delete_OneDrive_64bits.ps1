<#
.SYNOPSIS
Deletes OneDrive 64-bit installation and related files.

.DESCRIPTION
This script checks if the OneDriveSetup.exe file exists and proceeds to uninstall OneDrive, stop any running OneDrive processes, and remove all associated files and folders.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE

This example runs the script to delete the OneDrive 64-bit installation and related files.

#>
$targetMessage = "[0004_Delete_OneDrive_64bits] [no change] [compliant] No action completed, already on target"

if (Test-Path "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
    Start-Process -Wait "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe" "/uninstall"
    Write-Host "[0004_Delete_OneDrive_64bits] - Deleting OneDrive 64 bits..."
    Get-Process OneDrive | Stop-Process -Force
    Remove-Item -Path "$env:UserProfile\OneDrive" -Recurse -Force
    Remove-Item -Path "$env:SystemDrive\OneDriveTemp" -Recurse -Force
    Remove-Item -Path "$env:LocalAppData\Microsoft\OneDrive" -Recurse -Force
    Remove-Item -Path "$env:ProgramData\Microsoft OneDrive" -Recurse -Force

    # Test again after deletion
    if (-not (Test-Path "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe")) {		
        Write-Host $targetMessage
    }
    else {
        $failMessage = "[0004_Delete_OneDrive_64bits] [no change] [compliant] OneDrive deletion failed"
        Write-Host $failMessage
    }
}
else {	
    Write-Host "[0004_Delete_OneDrive_64bits] Path tested: $Env:SystemRoot\SysWOW64\OneDriveSetup.exe"
    Write-Host $targetMessage
}
