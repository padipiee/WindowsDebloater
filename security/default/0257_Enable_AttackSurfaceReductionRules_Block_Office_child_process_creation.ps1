# Windows 10 Pro / Enterprise
#Attack surface reduction
#Customize attack surface reduction rules
#Block Process Injection
#RULE :Block Office Child Process Creation
#GUID : D4F940AB-401B-4EFC-AADC-AD5F3C50688A

# Check status
Get-MpComputerStatus
Get-MpPreference | select Exclusion* | fl #Check exclusions
# Start tracing statements.
Set-PSDebug -Trace 1

try {
  powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EFC-AADC-AD5F3C50688A -AttackSurfaceReductionRules_Actions Enabled

}
finally {
  Set-PSDebug -Trace 0 # Turn tracing back off.
}


##Remove-MpPreference -ExclusionPath "C:\Users\XXX\AppData\Local\Temp\application.py"

#https://gist.github.com/mackwage/08604751462126599d7e52f233490efe?permalink_comment_id=3307824