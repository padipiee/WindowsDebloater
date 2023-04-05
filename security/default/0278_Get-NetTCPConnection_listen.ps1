# Get listening processes and then all



Write-Output "##### ALL #### "
Get-NetTCPConnection


Write-Output "LISTEN: "
new-alias grep select-string
Get-NetTCPConnection | Select-Object LocalAddress, LocalPort, State, OwningProcess | grep Listen


