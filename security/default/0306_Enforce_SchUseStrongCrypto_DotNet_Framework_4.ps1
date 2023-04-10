# 0306 Enforce SchUseStrongCrypto if .Net Framework 4.x is used...
#.NET Framework's last version is 4.8
#.NET Core starts as 5.x
# to check the value of the Release entry in the registry to find the versions of .NET Framework 4.5-4.8.1 that are installed:
#https://learn.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed


###TEST RIGHTS
function CheckRunAsAdmin {
  $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
  $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
  return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function CheckDotNetFramework()
{
    # Get the .NET version using "dotnet --version" command
    $dotnetVersion = (dotnet --version).Trim()

    # Check if the version starts with "5"
    if ($dotnetVersion.StartsWith("5"))
    {
        Write-Host "The .NET version starts with '5' so it is .Net Core.   .NET Framework's last version is 4.8 "
        return $false
    }

    return $true
}


if (-not (CheckRunAsAdmin)) {
  Write-Host  "Error: This script must be run as a Security.Principal.WindowsBuiltInRole::Administrator."
  exit 1
}

if (-not (CheckDotNetFramework)) {
  Write-Host  ".Net Core 5.x is installed. .NET Framework's last version is 4.8 so exiting "
  exit 1
}

###TEST .NET Framework old versions

# .NET Framework 2.0 
$regPathv2 = "HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727" 

if (!(Test-Path -Path $regPathv2  )) {
  Write-Host "Registry path not found: $regPathv2 ..... Continuing"
}

# .NET Framework 4.0 
$regPathv4NDP = "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" 
if (!(Test-Path -Path $regPathv4NDP  )) {
  Write-Host "Registry path not found: $regPathv4NDP ..... Continuing"
}


###Set SchUseStrongCrypto
if (!(Test-Path -Path "$regPathv4NDP\SchUseStrongCrypto")) {
  Write-Host "SchUseStrongCrypto configuration value not found. Enforcing it..."
  
  # Set SchUseStrongCrypto value to 1 to enforce strong cryptography
  Set-ItemProperty -Path $regPathv4NDP -Name "SchUseStrongCrypto" -Value 1
  
  Write-Host "SchUseStrongCrypto configuration value set to 1 to enforce strong cryptography."
} else {
  # Get SchUseStrongCrypto configuration value
  $schUseStrongCrypto = Get-ItemPropertyValue -Path $regPathv4NDP -Name "SchUseStrongCrypto" -ErrorAction SilentlyContinue
  
  Write-Host "SchUseStrongCrypto configuration value: $schUseStrongCrypto"
}
