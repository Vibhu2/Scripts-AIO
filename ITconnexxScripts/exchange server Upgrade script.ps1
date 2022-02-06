$LogFolder = "C:\itconnexx-a"
#$logfolder= Read-host " enter the log folder Path to log the ran commands and their output" 
Test-Path -Path C:\itconnexx-a
if ($? -eq "$false"){

    New-Item -Path C:\itconnexx-a -ItemType Directory
}
else {SilentlyContinue}



Start-Transcript -OutputDirectory "$logfolder"

$servername= "$env:COMPUTERNAME"
Write-Host Server name is $servername -ForegroundColor Green
$defaultPolicy = Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned -Force
$lastboot = ((get-date)-((Get-CimInstance Win32_OperatingSystem).LastBootUpTime))
$lastboot | Select-Object -Property Days,Hours,Minutes,seconds
Write-host " Importing Exchange snapin " -ForegroundColor Green
#Add-PSSnapIn -Name Microsoft.Exchange, Microsoft.Windows.AD
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn
Write-Host " Collecting Server information" -ForegroundColor Blue
Get-ServerComponentState $env:Computername 
Get-ExchangeServer | select name, serverrole, edition, admindisplayversion, isClientAccessServer
Get-Service -Name *exchange* | Format-Table -GroupBy Status -AutoSize
Get-ClientAccessServer | Select Name, AutoDiscoverServiceInternalUri
$Maildatabse = Get-MailboxDatabase
$maildatabseName = $Maildatabse.Name
#Test-PowerShellConnectivity -ClientAccessServer $serverName -VirtualDirectoryName "PowerShell (Default Web Site)" -TrustAnySSLCertificate

######################################################################################################

#KBfollowed- https://docs.microsoft.com/en-us/exchange/high-availability/manage-ha/manage-dags?view=exchserver-2019#performing-maintenance-on-dag-members
# we are taking server in to maintainence mode

Write-host " we are taking server in to maintainence mode " -ForegroundColor Magenta

write-host " To empty the transport queues, run the following command:" -BackgroundColor Yellow
Set-ServerComponentState $ServerName -Component HubTransport -State Draining -Requester Maintenance

Write-Host "To initiate the draining of the transport queues, run the following command:" -BackgroundColor Yellow
Restart-Service MSExchangeTransport

# need to check condition
Write-host "To begin the process of draining all Unified Messaging calls (in Exchange 2016 only), run the following command:" -BackgroundColor DarkYellow
Set-ServerComponentState $ServerName -Component UMCallRouter -State Draining -Requester Maintenance

#To place the server into maintenance mode, run:
 Write-Host "To place the server into maintenance mode, run:" -BackgroundColor Yellow
 Set-ServerComponentState $ServerName -Component ServerWideOffline -State Inactive -Requester Maintenance

 Write-host " Dismounting Mailbox Databse "
 Dismount-Database  -Identity $maildatabseName

 ####################################################################################################################################

 # Entring in to Verification Mode before Exchange Update


 Write-host "Entring in to Verification Mode before Exchange Update" -BackgroundColor White
 Write-host "To verify the server has been placed into maintenance mode, confirm that only Monitoring and RecoveryActionsEnabled are in an Active state when you run the" -ForegroundColor Cyan

$servername= "$env:COMPUTERNAME"
$ServerCompState =  Get-ServerComponentState $serverName | Format-Table Component,State -Autosize
$ServerCompState 

Write-Host "To verify the server is not hosting any active database copies"
Get-MailboxServer $ServerName
Get-MailboxServer $ServerName | Format-List DatabaseCopyAutoActivationPolicy

#Check Condition
Write-Host "To verify that the cluster node is paused, run:" -ForegroundColor Green
Get-ClusterNode $ServerName | Format-List
#check (if cluster service is not running its Good )
Write-Host "To verify that all transport queues have been emptied, run:"
#################################################################################################################################

Start-BitsTransfer -Source -Destination C:\itconnexx-a
Mount-DiskImage -ImagePath C:\ SW_DVD9_Exchange_Svr_2019_CU_8_MultiLang_Std_Ent_.iso_MLF_X22-47601.iso
Get-Volume
Mount-DiskImage C:\ExchangeSetupLogs\SW_DVD9_Exchange_Svr_2019_CU_8_MultiLang_Std_Ent_.iso_MLF_X22-47601.ISO -StorageType ISO

#############################################################################################################################################################3

We are Getting out of maintainence mode and Returning Server to its Active state

Write-Host "We are Getting out of maintainence mode and Returning Server to its Active state" -BackgroundColor White

Write-Host " We are Getting out of maintainence mode and Returning Server to its Active state" -BackgroundColor White
Write-Host "To configure the server as out of maintenance mode and ready to accept client connections, run:" -ForegroundColor Green
Set-ServerComponentState $ServerName -Component ServerWideOffline -State Active -Requester Maintenance

Write-host " Mounting Exchange Database " -ForegroundColor Green
Mount-Database -Identity $maildatabseName

#Condition check
#Write-Host "To allow the server to accept Unified Messaging calls (in Exchange 2016 only), run:" -ForegroundColor Green
Set-ServerComponentState $ServerName -Component UMCallRouter -State Active -Requester Maintenance


Write-Host "To access the DAG maintenance scripts, run the following command:" -ForegroundColor Green
CD $ExScripts

Write-Host "To enable the transport queues to resume accepting and processing messages, run:" -ForegroundColor Green
Set-ServerComponentState $ServerName -Component HubTransport -State Active -Requester Maintenance

Write-Host "To resume transport activity, run:" -ForegroundColor Green
Restart-Service MSExchangeTransport


Write-Host "Entering in to Final Verificatin Phase of the process " -BackgroundColor White
Write-Host "To verify the server is not in maintenance mode, run" -ForegroundColor Green
Get-ServerComponentState $ServerName | Format-Table Component,State -Autosize

####################################################################################################################################################################
#If you're installing an Exchange update, and the update process fails, it can leave some server components in an inactive state, which will be displayed in the output of the above
Write-Host "If you're installing an Exchange update, and the update process fails, it can leave some server components in an inactive state, which will be displayed in the output of the above" -BackgroundColor white
Get-ServerComponentState
Set-ServerComponentState $ServerName -Component ServerWideOffline -State Active -Requester Functional
Set-ServerComponentState $ServerName -Component Monitoring -State Active -Requester Functional
Set-ServerComponentState $ServerName -Component RecoveryActionsEnabled -State Active -Requester Functional
####################################################################################################################################################################
Test-Mailflow 
Test-ActiveDirectoryConnectivity
Test-ServiceHealth
get-queue
#Get-Queue | Get-Message | fl ( To check each message details)
Resolve-DnsName gmail.com -Type MX
Set-SendConnector "Out to internet" -ProtocolLoggingLevel Verbose

