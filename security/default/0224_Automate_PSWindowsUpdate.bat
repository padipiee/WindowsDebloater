::#In Windows 10, you can use the PSWindowsUpdate PowerShell module.
::#Powershell.exe -ExecutionPolicy RemoteSigned Get-PSRepository
::#Name                      InstallationPolicy   SourceLocation
::#----                      ------------------   --------------
::#PSGallery                 Untrusted            https://www.powershellgallery.com/api/v2
::
::#Powershell.exe -ExecutionPolicy RemoteSigned  Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
::#Powershell.exe -ExecutionPolicy RemoteSigned Install-Module PSWindowsUpdate
::
::
::#####
Powershell.exe -ExecutionPolicy RemoteSigned Install-WindowsUpdate

pause > nul