# Get the path to the Firefox profiles directory
$ProfilesPath = Join-Path $env:APPDATA "Mozilla\Firefox\Profiles"

# List files and directories in the profiles directory
# Check if the path exists
if (Test-Path -Path $ProfilesPath) {
    # If the path exists, get the child items
    Get-ChildItem -Path $ProfilesPath
} else {
    # If the path does not exist, output a message
    Write-Output "[0385_List_Details_Firefox_profiles] The path $ProfilesPath does not exist."
}

# Read the contents of the profiles.ini file
# Define the root directory to start the search
$rootDir = "C:\Users\*\AppData\Roaming"

# Define the name of the file to search for
$fileName = "profiles.ini"

# Search for the file
$foundFiles = Get-ChildItem -Path $rootDir -Filter $fileName -Recurse -ErrorAction SilentlyContinue

# Output the paths of the found files
$foundFiles | ForEach-Object {
    Write-Output "[0385_List_Details_Firefox_profiles] $_.FullName"
}