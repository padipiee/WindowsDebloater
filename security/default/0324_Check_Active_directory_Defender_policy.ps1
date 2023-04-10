
#https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/enable-cloud-protection-microsoft-defender-antivirus?view=o365-worldwide

function Check-GroupPolicyModule {
    $module = Get-Module -ListAvailable -Name GroupPolicy
    if ($module) {
        Write-Output "GroupPolicy module is available."
    } else {
        Write-Output "GroupPolicy module is not available."
        exit 1
    }
}

function Check-WDMapsReporting-GPO {
    # Import the GroupPolicy module
    Import-Module GroupPolicy
    
    # Get all GPOs that have settings related to Microsoft Defender
    $gpos = Get-GPO -All | Where-Object { $_.DisplayName -match "Windows Defender" }
    
    # Loop through each GPO and check if it has MAPSReporting settings
    foreach ($gpo in $gpos) {
        $gpoName = $gpo.DisplayName
        $gpoId = $gpo.Id.Guid
        $gpoSettings = Get-GPRegistryValue -Guid $gpoId -Key "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" -ValueName "MAPSReporting"
        
        # If GPO has MAPSReporting settings, display the GPO name and its value
        if ($gpoSettings) {
            $mapsReportingValue = $gpoSettings.Value -replace "^(0|1|2)$", { $_.Groups[1].Value }
            Write-Host "GPO Name: $gpoName"
            Write-Host "GPO ID: $gpoId"
            Write-Host "MAPSReporting Value: $mapsReportingValue"
            Write-Host "-----------------------------"
        }
    }
}

Check-GroupPolicyModule
Check-WDMapsReporting-GPO
