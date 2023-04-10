:: Deleting OneDrive 32 bits

if (Test-Path "$Env:SystemRoot\System32\OneDriveSetup.exe") {
    Start-Process -FilePath "$Env:SystemRoot\System32\OneDriveSetup.exe" -ArgumentList "/uninstall" -Wait
    Write-Host "0003 - Deleting OneDrive 32bits..."
    Get-Process -Name "OneDrive.exe" | ForEach-Object { $_.Kill() }
    Remove-Item -Path "$Env:UserProfile\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Env:SystemDrive\OneDriveTemp" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Env:LocalAppData\Microsoft\OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$Env:ProgramData\Microsoft OneDrive" -Recurse -Force -ErrorAction SilentlyContinue
}