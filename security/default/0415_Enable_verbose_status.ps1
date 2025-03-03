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
    If ((Get-CimInstance -Class "Win32_OperatingSystem").ProductType -eq 1) {
        $currentValue = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -ErrorAction SilentlyContinue)."VerboseStatus"
        if ($currentValue -ne 1) {
            Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -Type DWord -Value 1
            Write-Host "Verbose status messages enabled to Enable verbose startup/shutdown status messages"
        } else {
            Write-Host "Verbose status messages are already enabled to Enable verbose startup/shutdown status messages."
        }
    } else {
        if (Test-Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System") {
            Remove-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "VerboseStatus" -ErrorAction SilentlyContinue
            Write-Host "Removed verbose status messages for non-client OS."
        } else {
            Write-Host "Verbose status messages not applicable for non-client OS."
        }
    }
}

# Call the function to enable verbose status
EnableVerboseStatus
