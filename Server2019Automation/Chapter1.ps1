#>
    #Server 2019 Automation With powershell chapter1 
    #Setting up enviornment

#>

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
New-Item C:\Foo -ItemType Directory -Force                

(get-date) - (Get-ComputerInfo).OsLastBootUpTime
Get-Service | Where-Object {$_.Status -eq "Stopped" -and $_.Starttype -eq "Automatic"}

start-bits 