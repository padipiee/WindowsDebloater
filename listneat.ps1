Get-ChildItem -Path . -Recurse -File -Exclude *.reg -Include *.bat,*.ps1,*.py| Where-Object { $_.Attributes -ne "Directory"}  | where { $_.GetType().Name -eq "FileInfo" } | Sort-Object Name | Format-Table Name, Fullname -auto


