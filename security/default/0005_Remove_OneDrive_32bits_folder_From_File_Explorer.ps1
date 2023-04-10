
:: Remove the OneDrive 32bits  Folder From File Explorer by Editing the Registry  (System.IsPinnedToNameSpaceTree )


$regKey = "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"

$result = Get-ItemProperty -Path $regKey -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -ErrorAction SilentlyContinue

if (!$?) {
    Remove-ItemProperty -Path $regKey -Name "{018D5C66-4533-4307-9B53-224DE2ED1FE6}" -Force
    Write-Host "0005 - Removing the OneDrive 32bits folder From File Explorer by Editing the Registry HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6} (System.IsPinnedToNameSpaceTree )"
}