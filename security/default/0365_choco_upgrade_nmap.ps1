Write-Output "[0365_choco_upgrade_nmap]"
# Check if Chocolatey is installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
  Write-Output "Chocolatey is not installed. Please install Chocolatey first."
  exit
}

# Upgrade nmap
choco list nmap
choco upgrade nmap -y

# Link to nmap download page
#https://nmap.org/download