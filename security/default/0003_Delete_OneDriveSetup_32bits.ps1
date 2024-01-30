

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
	Write-Host "[0003_Delete_OneDriveSetup_32bits] - Uninstalling OneDrive 32bits..."

	Write-Output "[0003_Delete_OneDriveSetup_32bits] - Remove Onedrive from explorer sidebar"

	# BEGIN: be15d9bcejpp
	if (Get-Process -Name "OneDrive" -ErrorAction SilentlyContinue) {
		Write-Host "[0003_Delete_OneDriveSetup_32bits] - Stopping process OneDrive ..."
		Get-Process -Name "OneDrive" | Stop-Process -Force
		Write-Output "[0003_Delete_OneDriveSetup_32bits] - Kill OneDrive process"
	}
	else {
		Write-Host "[0003_Delete_OneDriveSetup_32bits] - Process OneDrive not found."
		

		Write-Output "[0003_Delete_OneDriveSetup_32bits] - Removing OneDrive leftovers"
		if (Test-Path "$env:localappdata\Microsoft\OneDrive") {
			Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:localappdata\Microsoft\OneDrive"
		}

		if (Test-Path "$env:programdata\Microsoft OneDrive") {
			Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:programdata\Microsoft OneDrive"
		}

		if (Test-Path "$env:systemdrive\OneDriveTemp") {
			Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:systemdrive\OneDriveTemp"
		}

		# check if directory is empty before removing:
		If ((Get-ChildItem "$env:userprofile\OneDrive" -Recurse | Measure-Object).Count -eq 0) {
			Write-Host "[0003_Delete_OneDriveSetup_32bits] - Check if directory is empty before removing"
			Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "$env:userprofile\OneDrive"
		}
		Write-Host "[0003_Delete_OneDriveSetup_32bits] - Uninstall process started..."
	}


	$folderPath = "$env:LocalAppData\Microsoft\OneDrive\*\amd64\"
	$fileName = "FileSyncShell64.dll"
	
	$filePath = Get-ChildItem -Path $folderPath -Filter $fileName -Recurse | Select-Object -First 1 -ExpandProperty FullName
	
	if ($null -ne $filePath) {
			Write-Host "Found $fileName at $filePath"
	} else {
			Write-Host "$fileName does not exist. Uninstall process will not proceed."
	}

	if (Test-Path -Path $filePath) {
		Write-Host "[0003_Delete_OneDriveSetup_32bits] - Uninstall process started..."

		# BEGIN: ed8c6549bwf9
		try {
			Import-Module -Name Microsoft.PowerShell.Security
			$acl = Get-Acl -Path $filePath
			$acl.SetAccessRuleProtection($true, $false)
			Set-Acl -Path $filePath -AclObject $acl
			Write-Host "[0003_Delete_OneDriveSetup_32bits] - testing ACL on $fileName"
		} catch {
			Write-Host "[0003_Delete_OneDriveSetup_32bits] - Cannot delete $fileName. Exiting the program."
			exit
		}
		# END: ed8c6549bwf9

		Start-Process -Wait "$env:SystemRoot\System32\OneDriveSetup.exe" "/uninstall"

		if (Test-Path "$env:UserProfile\OneDrive") {
			Remove-Item -Path "$env:UserProfile\OneDrive" -Recurse -Force
		}
	}
	else {
		Write-Host "[0003_Delete_OneDriveSetup_32bits] - FileSyncShell64.dll does not exist. Uninstall process will not proceed."
	}
}

if (Test-Path "$env:UserProfile\OneDrive") {
	Remove-Item -Path "$env:UserProfile\OneDrive" -Recurse -Force
}

if (Test-Path "$env:SystemDrive\OneDriveTemp") {
	Remove-Item -Path "$env:SystemDrive\OneDriveTemp" -Recurse -Force
}

if (Test-Path "$env:LocalAppData\Microsoft\OneDrive") {
	Remove-Item -Path "$env:LocalAppData\Microsoft\OneDrive" -Recurse -Force
}

if (Test-Path "$env:ProgramData\Microsoft OneDrive") {
	Remove-Item -Path "$env:ProgramData\Microsoft OneDrive" -Recurse -Force
}
# Test again after deletion
if (-not (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe")) {		
	Write-Host $targetMessage
}
else {
	$failMessage = "[0003_Delete_OneDriveSetup_32bits] [ERROR] OneDrive deletion failed"
	Write-Host $failMessage
}

