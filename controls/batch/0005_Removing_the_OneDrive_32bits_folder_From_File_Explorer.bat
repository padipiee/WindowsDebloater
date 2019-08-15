
REM Remove the OneDrive 32bits  Folder From File Explorer by Editing the Registry  (System.IsPinnedToNameSpaceTree )

reg query "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v {018D5C66-4533-4307-9B53-224DE2ED1FE6} > nul
if not errorlevel 1 (
	reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f 
	echo 0005 - Removing the OneDrive 32bits folder From File Explorer by Editing the Registry HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6} (System.IsPinnedToNameSpaceTree )
)