<#
.SYNOPSIS
Automatically downloads and installs the latest version of osquery.

.DESCRIPTION
This PowerShell script fetches the latest release URL of osquery from the GitHub API, downloads the osquery MSI installer, and installs osquery on the local machine. It also adds the osqueryi executable to the PATH environment variable. After installation, it verifies the osquery installation by checking the version of osqueryi.

.PARAMETER None

.EXAMPLE
.\0348_install_latest_osquery.ps1

.NOTES
Author: [Your Name]
Date: [Current Date]
Version: 1.0
#>
# PowerShell Script to Automatically Download and Install the Latest osquery

try {
    # Function to fetch the latest osquery release URL
    function Get-OsqueryLatestReleaseUrl {
        $apiUrl = "https://api.github.com/repos/osquery/osquery/releases/latest"
        $releaseInfo = Invoke-RestMethod -Uri $apiUrl -Headers @{"Accept" = "application/vnd.github.v3+json" } -ErrorAction Stop
        $msiAsset = $releaseInfo.assets | Where-Object { $_.name -like "*.msi" }
        return $msiAsset.browser_download_url
    }

    # Get latest release URL
    $downloadUrl = Get-OsqueryLatestReleaseUrl

    if (-not $downloadUrl) {
        throw "Failed to find osquery MSI download URL."
    }

    # Define download path
    $downloadPath = "$env:TEMP\osquery-latest.msi"

    # Downloading the latest osquery MSI
    Write-Host "Downloading osquery from $downloadUrl"
    Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath -ErrorAction Stop

    # Verify if the downloaded file exists
    if (-not (Test-Path $downloadPath)) {
        throw "Failed to download osquery MSI."
    }

    # Installing osquery
    Write-Host "Installing osquery..."
    Start-Process msiexec.exe -Wait -ArgumentList "/i $downloadPath /quiet"

    Write-Host "osquery installation completed."

    # Add osqueryi to the PATH
    $osqueryPath = (Get-Item -Path $downloadPath).DirectoryName
    $env:Path += ";$osqueryPath"

    Write-Host "osqueryi added to the PATH."
}
catch {
    Write-Host "An error occurred: $_"
}

# Verify osquery installation
try {
    $osqueryPath = "C:\Program Files\osquery\osqueryi.exe"
    $osqueryVersion = & $osqueryPath "--version"
    Write-Host "C:\Program Files\osquery\osqueryi.exe version: $osqueryVersion"
}
catch {
    Write-Host "Failed to verify osquery installation: $_"
}
