

<#
.SYNOPSIS
Deletes OneDrive 32-bit installation and related files.

.DESCRIPTION
This script checks if the OneDriveSetup.exe file exists in the System32 directory and proceeds to uninstall OneDrive, stop any running OneDrive processes, and remove all associated files and folders.

.PARAMETER None

.INPUTS
None

.OUTPUTS
None

.EXAMPLE
.\0003_Delete_OneDriveSetup_32bits.ps1

This example runs the script to delete the OneDrive 32-bit installation and related files.

#>
$targetMessage = "[0003_Delete_OneDriveSetup_32bits] [no change] [compliant] No action completed, already on target"

if (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
	Start-Process -Wait "$env:SystemRoot\System32\OneDriveSetup.exe" "/uninstall"
	Write-Host "[0003] - Deleting OneDrive 32bits..."
	Get-Process OneDrive | Stop-Process -Force
	Remove-Item -Path "$env:UserProfile\OneDrive" -Recurse -Force
	Remove-Item -Path "$env:SystemDrive\OneDriveTemp" -Recurse -Force
	Remove-Item -Path "$env:LocalAppData\Microsoft\OneDrive" -Recurse -Force
	Remove-Item -Path "$env:ProgramData\Microsoft OneDrive" -Recurse -Force

	# Test again after deletion
	if (-not (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe")) {		
		Write-Host $targetMessage
	}
	else {
		$failMessage = "[0003] [no change] [compliant] OneDrive deletion failed"
		Write-Host $failMessage
	}
}
else {	
	Write-Host $targetMessage
}

