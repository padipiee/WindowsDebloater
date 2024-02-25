

#The datareporting folder within your Firefox profile directory contains various files related to data collection and reporting.
#session-state.json : This file stores information about the current session, including open tabs, windows, and other session-related data.
# state.json : Similar to session-state.json, this file also contains session-related information.
# archived folder : Inside the archived folder, you’ll find dated subfolders. Each dated subfolder contains multiple files with names like 
# 1439862649871.c0086185-14f2-45b3-a1f5-6fbcb95f58c5.saved-session.jsonlz4. These files are compressed using jsonlz4 compression (similar to automatically created bookmark backups 
# in the bookmarkbackups folder
# The exact content of these files depends on the data collected by Firefox, but they may include telemetry, 
# health report data, and other usage-related information


# Define the path to the Firefox profile folder
$FirefoxProfilePath = "C:\Users\*\AppData\Roaming\Mozilla\Firefox\Profiles\*.default-release\datareporting"

# Resolve the wildcard path to actual directories
$ResolvedPaths = Resolve-Path $FirefoxProfilePath
Write-Host "Resolved paths:"
$ResolvedPaths | ForEach-Object {
    Write-Host $_.Path
}

# Remove the cache and history files
$Items = @('archived')
$DeletedFiles = @()
$ResolvedPaths | ForEach-Object {
    $resolvedPath = $_.Path
    $Items | ForEach-Object {
        $itemPath = Join-Path $resolvedPath $_
        if (Test-Path $itemPath) {
            # Get the subdirectories under "Archived"
            $subDirs = Get-ChildItem -Path $itemPath -Directory
            $subDirs | ForEach-Object {
                Write-Host "Subdirectory: $($_.FullName)"
                # Get all files recursively
                $allFiles = Get-ChildItem -Path $_.FullName -Recurse -File
                Write-Host "Files:"
                $allFiles | ForEach-Object {
                    Write-Host $_.FullName
                }
                # Delete *.jsonlz4 files recursively
                $filesToDelete = $allFiles | Where-Object { $_.Extension -eq ".jsonlz4" }
                $DeletedFiles += $filesToDelete
                $filesToDelete | ForEach-Object {
                    Write-Host "Attempting to delete: $($_.FullName)"
                    $_ | Remove-Item -Force
                }
            }
        }
    }
}

if ($DeletedFiles.Count -gt 0) {
    Write-Host "Deleted files:"
    $DeletedFiles | ForEach-Object {
        Write-Host $_.FullName
    }
    Write-Host "[0382_Delete_Firefox_default_archived] Firefox archived (jsonlz4) files have been cleared."
} else {
    Write-Host "[0382_Delete_Firefox_default_archived] Firefox archived (jsonlz4) no files cleared review manually."
}