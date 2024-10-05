# Enable verbose startup/shutdown status messages
Function EnableVerboseStatus {
    <#
    .SYNOPSIS
    Enables or disables verbose startup/shutdown status messages on a Windows system.

    .DESCRIPTION
    This script checks if the operating system is a client version of Windows (ProductType -eq 1).
    If it is, it enables verbose status messages by setting the "VerboseStatus" registry key to 1.
    If it is not, it removes the "VerboseStatus" registry key to disable verbose status messages.

    .PARAMETER None
    This script does not take any parameters.

    .EXAMPLE
    .\0415_Enable_verbose_status.ps1
    This example runs the script to enable or disable verbose status messages based on the operating system type.

    .NOTES
    File Path: /C:/DATA/GIT/Windows10Debloater/security/default/0415_Enable_verbose_status.ps1
    #>
    Write-Output "Enabling verbose startup/shutdown status messages..."
    If ((Get-CimInstance -Class "Win32_OperatingSystem").ProductType -eq 1) {
        Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Type DWord -Value 1
    }
    Else {
        Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -ErrorAction SilentlyContinue
    }
}

# Call the function to enable verbose status
EnableVerboseStatus
