function Enable-PSScriptBlockLogging
{

    # Registry key
    $basePath = 'HKLM:\\Software\\Policies\\Microsoft\\Windows\\PowerShell\\ScriptBlockLogging'

    # Create the key if it does not exist
    if(-not (Test-Path $basePath))
    {

        $null = New-Item $basePath -Force

        # Create the correct properties
         New-ItemProperty $basePath -Name "EnableScriptBlockLogging" -PropertyType Dword

    }
    
    # These can be enabled (1) or disabled (0) by changing the value
    Set-ItemProperty $basePath -Name "EnableScriptBlockLogging" -Value "1"

}

function Enable-PSScriptBlockLoggingWow6432Node
{

    # Registry key
	$basePath = 'HKLM:\\SOFTWARE\\Wow6432Node\\Policies\\Microsoft\\Windows\\PowerShell\\ScriptBlockLogging'

    # Create the key if it does not exist
    if(-not (Test-Path $basePath))
    {

        $null = New-Item $basePath -Force

        # Create the correct properties
         New-ItemProperty $basePath -Name "EnableScriptBlockLogging" -PropertyType Dword

    }
    
    # These can be enabled (1) or disabled (0) by changing the value
    Set-ItemProperty $basePath -Name "EnableScriptBlockLogging" -Value "1"

}

Enable-PSScriptBlockLoggingWow6432Node


#https://github.com/ticketmaster/poshspec/issues/63
#
#https://www.elastic.co/guide/en/beats/winlogbeat/master/winlogbeat-module-powershell.html
#
#HKCU/HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging: EnableModuleLogging = 1
#HKCU/HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging \ModuleNames: * = *
#HKCU/HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging: EnableScriptBlockLogging = 1
#HKCU/HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging: EnableScriptBlockInvocationLogging = 1
#
#https://sid-500.com/2017/08/16/monitoring-windows-powershell-enable-module-logging/
#
#https://adamtheautomator.com/powershell-logging-recording-and-auditing-all-the-things/
#
#https://getadmx.com/?Category=Windows_10_2016&Policy=Microsoft.Policies.PowerShell::EnableModuleLogging
#
#
#https://www.eventsentry.com/blog/2018/01/powershell-p0wrh11-securing-powershell.html
#
#https://docs.splunk.com/Documentation/UBA/5.0.3/GetDataIn/AddPowerShell
#
#
#https://searchwindowsserver.techtarget.com/tutorial/Set-up-PowerShell-script-block-logging-for-added-security
#
#
#
#https://static1.squarespace.com/static/552092d5e4b0661088167e5c/t/59c1814829f18782e24f1fe2/1505853768977/Windows+PowerShell+Logging+Cheat+Sheet+ver+Sept+2017+v2.1.pdf?irgwc=1&clickid=Vuny%3AMS7mxyOWNfwUx0Mo38MUkiSVA2cEz05Ss0&utm_medium=pp&utm_source=adgoal%20GmbH&utm_campaign=adgoal%20GmbH&channel=pp&subchannel=adgoal%20GmbH&source=adgoal%20GmbH
#
#
#WevtUtil qe "Microsoft-Windows-PowerShell/Operational" /q:"*[System[(EventID=4104)]]" /c:1000 /rd:true /f:text | findstr /i "Get-"
#
#WevtUtil qe "Windows PowerShell" /q:"*[System[(EventID=501)]]" /c:1000 /rd:true /f:text | findstr "Logged CommandLine Cmdlet Script"
#
#WevtUtil qe “Windows PowerShell” /q:"*[System[(EventID=500)]]" /c:5 /rd:true /f:text | find /I “CommandName”