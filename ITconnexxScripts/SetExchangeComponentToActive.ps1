<#
.NOTES
Written by Adnan Rafique @ExchangeITPro
V1.1 08.06.2014
.SYNOPSIS
Bring componet to active state.
.DESCRIPTION
Bring component state to active state.
.PARAMETER Server
Specifies the DAG node Server name to be bring the component to active state.
.EXAMPLE
PS> .\SetExchangeComponentToActive.ps1 -Server Server1
#>

#Requires -version 3.0

[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true,
    HelpMessage="Enter the name of Server to set component to active.")]
    [string]$Server
)

#Designates that the server is out of maintenance mode
Set-ServerComponentState $Server -Component ServerWideOffline -State Active -Requester Functional
Set-ServerComponentState $Server -Component Monitoring -State Active -Requester Functional
Set-ServerComponentState $Server -Component RecoveryActionsEnabled -State Active -Requester Functional

#Get the status of component 
Get-ServerComponentState $Server | ft Component,State -Autosize
Write-Host "$Server is now completely out of maintenance mode and component are active and functional." -ForegroundColor Yellow