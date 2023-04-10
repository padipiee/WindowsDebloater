:: Deleting OneDrive 64 bits

if (Test-Path "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
    Start-Process -FilePath "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait
    Write-Host "0004 - Deleting OneDrive 64bits..."
    Get-Process -Name "OneDrive.exe" | ForEach-Object { $_.Kill() }
    Remove-Item -Path "$Env:UserProfile\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Env:SystemDrive\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Env:LocalAppData\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Env:ProgramData\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
}

