<#
.SYNOPSIS
Installs PowerShell 7 using the MSI installer.

.DESCRIPTION
This script downloads and installs PowerShell 7 on the local machine using the specified MSI installer URL. It then removes the installer file after installation.

.PARAMETER url
The URL of the PowerShell 7 MSI installer.

.OUTPUTS
None.

.EXAMPLE
.\0366_install_powershell7.ps1 -url "https://github.com/PowerShell/PowerShell/releases/download/v7.1.3/PowerShell-7.1.3-win-x64.msi"
#>

# Check if pwsh is in PATH
if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
  # Check the default installation paths
  $defaultPaths = @(
    "C:\Program Files\PowerShell\7\pwsh.exe",
    "$env:ProgramFiles\PowerShell\7\pwsh.exe"
  )

  foreach ($path in $defaultPaths) {
    if (Test-Path $path) {
      Write-Output "[0366_install_powershell7] Found pwsh at $path"
      # Add the path to the PATH environment variable
      $env:PATH += ";$(Split-Path $path)"
      break
    }
    else {
      Write-Output "[0366_install_powershell7] pwsh not found at $path"
    }
  }
}

# Define the URL of the PowerShell 7 MSI installer
$url = "https://github.com/PowerShell/PowerShell/releases/download/v7.1.3/PowerShell-7.1.3-win-x64.msi"

# Define the path where the installer will be saved
$output = "$env:TEMP\PowerShell-7.1.3-win-x64.msi"

if (-not (Get-Command pwsh -ErrorAction SilentlyContinue)) {
  Write-Output "pwsh is not found"

  # Download the installer
  Invoke-WebRequest -Uri $url -OutFile $output

  # Install PowerShell 7
  $installProcess = Start-Process -FilePath msiexec -ArgumentList "/i $output /quiet /norestart" -Wait -NoNewWindow -PassThru

  # Check the return code of the installation process
  if ($installProcess.ExitCode -eq 0) {
    Write-Host "[0366_install_powershell7] PowerShell 7 installation successful."
  }
  else {
    Write-Host "[0366_install_powershell7] PowerShell 7 installation failed."
  }

  # Remove the installer
  if (Test-Path $output) {
    Remove-Item -Path $output
  }
}
else {
  Write-Host "[0366_install_powershell7] PowerShell 7 is already installed."
}