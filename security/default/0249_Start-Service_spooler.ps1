# REF 0234_print_disable_printnightmare
#CVE-2021-34527
#Print Nightmare
#Windows Print Spooler Remote Code Execution Vulnerability
#https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-34527

Get-Service -Name Spooler
Start-Service -Name Spooler -Force

