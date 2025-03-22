## Script to get all AD users who have logged on in the last X days
## Requires Active Directory module

# Check if Active Directory module is available and try to import it
if (-not (Get-Module -Name ActiveDirectory -ListAvailable)) {
    try {
        Import-Module ActiveDirectory -ErrorAction Stop
        Write-Host "Successfully loaded Active Directory module." -ForegroundColor Green
    }
    catch {
        Write-Error "The Active Directory module is not installed. Please install RSAT tools or run this on a domain controller."
        Write-Error "Install instructions: https://docs.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps"
        exit 1
    }
}

# Number of days to look back
$daysBack = 5
$date = (Get-Date) - (New-TimeSpan -Days $daysBack)

Write-Host "Getting AD users who logged on after $($date.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor Cyan

# Run the query with proper error handling
try {
    $users = Get-ADUser -Filter "LastLogonDate -gt '$date'" -Properties LastLogonDate | Select-Object Name, SamAccountName, LastLogonDate
    
    if ($users) {
        Write-Host "Found $($users.Count) users who logged in within the last $daysBack days." -ForegroundColor Green
        $users | Format-Table -AutoSize
    }
    else {
        Write-Host "No users found who logged in within the last $daysBack days." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Error querying Active Directory: $_"
}


