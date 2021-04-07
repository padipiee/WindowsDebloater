# Windows 10 Pro / Enterprise
#Attack surface reduction
#Customize attack surface reduction rules
#Block Process Injection
#RULE : Block Office applications from injecting code into other processes	
#GUID : 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84 -AttackSurfaceReductionRules_Actions Enabled

#https://docs.microsoft.com/en-us/windows/security/threat-protection/microsoft-defender-atp/customize-attack-surface-reduction

#https://blog.sevagas.com/IMG/pdf/bypass_windows_defender_attack_surface_reduction.pdf

#https://github.com/MicrosoftDocs/windows-itpro-docs/blob/public/windows/security/threat-protection/microsoft-defender-atp/customize-attack-surface-reduction.md