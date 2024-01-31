<#
.SYNOPSIS
Installs Chocolatey package manager if it is not already installed.

.DESCRIPTION
This script checks if Chocolatey is already installed on the system. If not, it installs Chocolatey by downloading and executing the installation script from the official Chocolatey website. The script also verifies the installation by displaying the installed version of Chocolatey.

.PARAMETER None

.EXAMPLE
.\0364_get_chocolatey_iex.ps1

This example runs the script to install Chocolatey.

.NOTES
Author: [Your Name]
Date: [Current Date]
Version: 1.0
#>
# Check if Chocolatey is already installed
if (Get-Command choco -ErrorAction SilentlyContinue) {
  Write-Output "[0364_get_chocolatey_iex] - Chocolatey is already installed at '$((Get-Command choco).Source)'. Use 'choco' to manage packages."
  exit
}

# Check if running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
  Write-Warning "[0364_get_chocolatey_iex] - You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator!"
  Break
}

# Set execution policy
Set-ExecutionPolicy Bypass -Scope Process -Force

# Ensure use of TLS1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

# Download and install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Verify installation
choco -v