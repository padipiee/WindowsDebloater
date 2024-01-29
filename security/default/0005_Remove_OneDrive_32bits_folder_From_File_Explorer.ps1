<#
.SYNOPSIS
Removes the OneDrive 32bits folder from File Explorer by editing the registry.

.DESCRIPTION
This script removes the OneDrive 32bits folder from File Explorer by editing the registry key "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}".
If the registry value is not found, it means that the OneDrive 32bits folder is already removed.

.NOTES
Author: [Your Name]
Date: [Current Date]
#>

$regKey = "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"

# Check if the registry key exists
if (Test-Path $regKey) {
    $registryValue = Get-ItemProperty -Path $regKey -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -ErrorAction SilentlyContinue

    if ($null -eq $registryValue) {
        Remove-ItemProperty -Path $regKey -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force
        Write-Host "[0005_Remove_OneDrive_32bits_folder_From_File_Explorer] - Removing the OneDrive 32bits folder From File Explorer by Editing the Registry HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6} (System.IsPinnedToNameSpaceTree )"
    }
    else {
        Write-Host "[0005_Remove_OneDrive_32bits_folder_From_File_Explorer] [no change][compliant] No action completed, already on target"
    }
}
else {
    Write-Host "Registry key $regKey does not exist"
    Write-Host "[0005_Remove_OneDrive_32bits_folder_From_File_Explorer] [no change][compliant] No action completed, already on target"
}