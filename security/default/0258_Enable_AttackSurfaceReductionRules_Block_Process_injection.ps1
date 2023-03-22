# Windows 10 Pro / Enterprise
#Attack surface reduction
#Customize attack surface reduction rules
#RULE : Block process injection
#GUID : 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84


# Check status
Get-MpComputerStatus
Get-MpPreference | select Exclusion* | fl #Check exclusions
# Start tracing statements.
Set-PSDebug -Trace 1

try {

  powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84 -AttackSurfaceReductionRules_Actions Enabled

}
finally {
  Set-PSDebug -Trace 0 # Turn tracing back off.
}



#https://gist.github.com/mackwage/08604751462126599d7e52f233490efe?permalink_comment_id=3307824