#region Important Links 
____________________________________________________________________________________________________
#Additional Modules for the Job if Needed for other work
#link - https://github.com/gavsto/AutomateAPI/wiki/Pre-requisites-and-Install
#link - https://github.com/LabtechConsulting

Install-Module AutomateAPI
Install-Module PoshRSJob
#endregion

#____________________________________________________________________________________________________
Find-Module AutomateAPI
Install-Module -Name AutomateAPI
Get-InstalledModule -Name AutomateAPI
Import-Module AutomateAPI
#_____________________________________________________________________________________________________

Function Get-connected {

#Connecting To automate API

$username = "vbhatnagar"
$password = ConvertTo-SecureString "C0mpl3xP@ssw0rd!!" -AsPlainText -Force
$PsCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Connect-AutomateAPI -Server https://automate.itconnexx.com -Credential $PsCred
$link = 'https://sc.itconnexx.com'
Write-host Connected to Automate API -ForegroundColor Cyan

# Connecting to ControlCenter API

$username = "AutomateAPI"
$password = ConvertTo-SecureString "APIUser123" -AsPlainText -Force
$APICred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Connect-ControlAPI -Server "$link" -Credential $APICred
Write-Host Connected successfully to Control API -ForegroundColor Cyan

# performaing actions 

}

#region ( Repair Automate )

    Write-host Getting offline machines

    Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Export-CSV C:\itconnexx-a\AutomateLists.csv
    Invoke-Item -Path C:\itconnexx-a\AutomateLists.csv

    #Check list for number of machines listed

    Write-host Restarting offline machines

    Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Restart

    # This will try to Repair or update the Agent

    Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Update 

    #If the Restart action doesn't fix the issue, trying reinstalling.

    Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Reinstall

#endregion

#_______________________________________________________________________________________________________________

#region example to get a machine info by its name
    #https://github.com/gavsto/AutomateAPI/wiki/Get-AutomateComputer

    Get-AutomateComputer -ComputerName itccw1 | Out-GridView
    Get-AutomateComputer -RebootNeeded  $true | Out-GridView
    Get-AutomateComputer -NotSeenInDays 90 | Select-Object Computername , DomainName | Clip
    Get-AutomateComputer -Condition "(RemoteAgentLastContact <= 2019-12-18T00:50:19.575Z)"
    Get-AutomateClient -AllClients | Select-Object Id, Name ,Company ,Address1, City ,State,Country,ZipCode,PhoneNumber | Out-GridView
    Get-AutomateClient -ClientId 3 ( Not working need to submit this bug )
   
    # Running Commands on remote computer

    Get-AutomateComputer  -ComputerName apple | Get-AutomateControlInfo | Invoke-ControlCommand -PowerShell -Command {Get-Process}

    # Running Commands on Multiple remote computer

    Get-AutomateComputer -ClientId 1 | Select-Object computername,ID | Get-AutomateControlInfo | Invoke-ControlCommand -PowerShell -Command {Hostname}

#endregion

#_______________________________________________________________________________________________________________


