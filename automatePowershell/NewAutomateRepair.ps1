#https://github.com/gavsto/AutomateAPI/wiki/Autofix-Broken-Agents
#https://github.com/gavsto/AutomateAPI/wiki/Get-AutomateComputer
#https://github.com/gavsto/AutomateAPI
#https://github.com/gavsto/AutomateAPI/tree/master/Docs

#Install-Module PoshRSJob
#Install-Module AutomateAPI
Update-Module -Verbose
Import-Module AutomateAPI,PoshRSJob,ConnectWiseControlAPI,ConnectWiseManageAPI,Connect-AutomateAPI


Function Get-connected {

#Connecting To automate API


Import-Module AutomateAPI,PoshRSJob
$APIClientID = "97c44153-2d3c-4296-8013-64f304e1d71b"
$username = "vbhatnagar"
$password = ConvertTo-SecureString 'N3wP@$$w0rd!!' -AsPlainText -Force
$PsCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Connect-AutomateAPI -Server https://automate.itconnexx.com -Credential $PsCred -ClientID $APIClientID
connect-

Write-host Connected to Automate API -ForegroundColor Cyan

# Connecting to ControlCenter API

$link = 'https://sc.itconnexx.com'
$username = "vbhatnagar"
$password = ConvertTo-SecureString "C0mpl3xP@ssw0rd!!" -AsPlainText -Force
$APICred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Connect-ControlAPI -Server "$link" -Credential $APICred
Write-Host Connected successfully to Control API -ForegroundColor Cyan

# performaing actions 

}

Get-AutomateComputer -Online $False | Compare-AutomateControlStatus

$offline = Get-AutomateComputer -Online $False
$offline | Select-Object -Property ComputerID,ComputerName,Client,Status | Out-File C:\Intel\offlinemachines.txt

$offline | Repair-AutomateAgent -Action Restart -Verbose

Get-Command -Module AutomateAPI

$Object = Compare-AutomateControlStatus -AllResults
Connect-ControlAPI