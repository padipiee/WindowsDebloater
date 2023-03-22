# Windows 10 Pro / Enterprise
#Attack surface reduction
#Customize attack surface reduction rules
#RULE : Block Win32 API calls in macros
#GUID : 92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B -AttackSurfaceReductionRules_Actions Enabled

#https://gist.github.com/mackwage/08604751462126599d7e52f233490efe?permalink_comment_id=3307824