#Automate API key - 97c44153-2d3c-4296-8013-64f304e1d71b

#region Important Links 

    #Additional Modules for the Job if Needed for other work
    #Link - https://github.com/LabtechConsulting
    #link - https://github.com/gavsto/AutomateAPI/wiki/Pre-requisites-and-Install
    #link - https://github.com/christaylorcodes/ConnectWiseControlAPI

    Install-Module 'AutomateAPI' -verbose -force
    Install-Module 'PoshRSJob' -verbose -force
    Install-module 'ConnectWiseControlAPI'-verbose -force
    Install-Module 'ConnectWiseManageAPI' -verbose -force
    
    Import-Module -Name AutomateAPI,PoshRSJob,ConnectWiseControlAPI,ConnectWiseManageAPI -Verbose
 
    

#endregion

#_______________________________________________________________________________________________________________
#region
    #Find-Module AutomateAPI
    #Install-Module -Name AutomateAPI
    #Get-InstalledModule -Name AutomateAPI
    #Import-Module AutomateAPI
#endregion

Connect-AutomateAPI -Credential vbhatnagar
User- vbhatnagar
Password - C0mpl3xP@ssw0rd!!

Connect-ControlAPI -Server https://automate.itconnexx.com -APIKey '97c44153-2d3c-4296-8013-64f304e1d71b'
$api= 97c44153-2d3c-4296-8013-64f304e1d71b
Connect-ControlAPI -Server https://automate.itconnexx.com

Import-Module AutomateAPI,PoshRSJob
$APIClientID = "97c44153-2d3c-4296-8013-64f304e1d71b"
$username = "vbhatnagar"
$password = ConvertTo-SecureString 'C0mpl3xP@ssw0rd!!' -AsPlainText -Force
$PsCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Connect-AutomateAPI -Server https://automate.itconnexx.com -Credential $PsCred -ClientID $APIClientID


$link = 'https://sc.itconnexx.com'
$username = "vbhatnagar"
$password = ConvertTo-SecureString "C0mpl3xP@ssw0rd!!" -AsPlainText -Force
$APICred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Connect-ControlAPI -Server "$link" -Credential $APICred
Write-Host Connected successfully to Control API -ForegroundColor Cyan



#_______________________________________________________________________________________________________________
Function Set-enviornment {

    Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
    $onlineversion = (Find-Module AutomateAPI)
    $localModule = Get-InstalledModule -Name AutomateAPI
    $ModuleName = "AutomateAPI"

    if (Get-InstalledModule -Name $ModuleName) {

        Write-Host "Module exists" -ForegroundColor Green
    } 
    else{
        Write-Host "$ModuleName Module does not exist" -ForegroundColor Red
        Write-Host "Installing $ModuleName Module " -ForegroundColor Green
        Install-Module $ModuleName -Force
        }
 
 #_______________________________________________________________________________________________

    $onlineversion = (Find-Module AutomateAPI)
    $localModule = Get-InstalledModule -Name AutomateAPI
    $ModuleName = "AutomateAPI"
 
    if ( $onlineversion.version -eq $localModule.version ){
 
     Write-Host  module is updated

    }elseif ($onlineversion.version -gt $localModule.version) {

     Write-host Updated Module Found online Updating local copy
     Find-Module "$ModuleName" | Install-Module -Force

    }else{
     Write-Host  there is some error please contact administator
    }

    #region Supporting and testing code
        #Uninstall-Module -Name AutomateAPI -Verbose -AllVersions
        #Get-InstalledModule AutomateAPI -AllVersions
        #Find-Module -Name AutomateAPI -AllVersions
        #Install-Module -Name AutomateAPI -RequiredVersion 1.0.9
    #endregion
   
}

Function Get-connected {

#Connecting To automate API
N3wP@$$w0rd!!

Import-Module AutomateAPI,PoshRSJob
$username = "vbhatnagar"
$password = ConvertTo-SecureString 'C0mpl3xP@ssw0rd!!' -AsPlainText -Force

$PsCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Connect-AutomateAPI -Server https://automate.itconnexx.com -Credential $PsCred

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

<#region ( Repair Automate )

    Write-host Getting offline machines

    $Difference = Get-AutomateComputer -Online $False | Compare-AutomateControlStatus
    $DifferenceResults = $Difference | Select-Object -Property Client,DomainName,Computername,OnlineStatusAutomate
    $DifferenceResults
    $Difference | Export-CSV C:\itconnexx-a\AutomateLists.csv -Force
    #Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Export-CSV C:\itconnexx-a\AutomateLists.csv
    #Invoke-Item -Path C:\itconnexx-a\AutomateLists.csv

    #Check list for number of machines listed

    $Difference | Repair-AutomateAgent -Action Restart -Verbose 

    Write-host Restarting offline machines

    Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Restart

    # This will try to Repair or update the Agent

    Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Update 

    #If the Restart action doesn't fix the issue, trying reinstalling.

    Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Reinstall

#>

#_______________________________________________________________________________________________________________
<#region ( example )

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

    Get-AutomateClient -AllClients | Select-Object ID,Name,Company
    Get-AutomateComputer -ClientId 1 | Select-Object computername,ID | Get-AutomateControlInfo | Invoke-ControlCommand -PowerShell -Command {Hostname}

#>



