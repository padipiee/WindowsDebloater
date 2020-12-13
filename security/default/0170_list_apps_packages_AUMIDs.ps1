

#list all system apps with path
Get-AppxPackage -PackageTypeFilter Main | ? { $_.SignatureKind -eq "System" } | Sort Name | Format-Table Name, InstallLocation


#list builtin provisioned apps that are installed  
Get-AppxProvisionedPackage -Online | select DisplayName

#List user  apps
Get-AppxPackage | Where-Object {$_.Isframework -eq $false -and $_.NonRemovable -eq $false} | select Name


#list Aumids for all  users
function listAumids( $userAccount ) {

    if ($userAccount -eq "allusers")
    {
        # Find installed packages for all accounts. Must be run as an administrator in order to use this option.
        $installedapps = Get-AppxPackage -allusers
    }
    elseif ($userAccount)
    {
        # Find installed packages for the specified account. Must be run as an administrator in order to use this option.
        $installedapps = get-AppxPackage -user $userAccount
    }
    else
    {
        # Find installed packages for the current account.
        $installedapps = get-AppxPackage
    }

    $aumidList = @()
    foreach ($app in $installedapps)
    {
        foreach ($id in (Get-AppxPackageManifest $app).package.applications.application.id)
        {
            $aumidList += $app.packagefamilyname + "!" + $id
        }
    }

    return $aumidList
}

listAumids("allusers")