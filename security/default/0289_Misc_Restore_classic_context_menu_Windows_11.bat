:: Windows 11 : restaure the classic right-clic context menu in Explorer
::https://www.winhelponline.com/blog/get-classic-full-context-menu-windows-11/
:: Disable "Show more options" context menu in Windows 11

reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /ve /d "" /f
reg query HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32