
#https://github.com/gavsto/AutomateAPI
# Github URL - https://github.com/gavsto/AutomateAPI
# GITHUB URL - https://github.com/LabtechConsulting/LabTech-Powershell-Module


Find-Module AutomateAPI
Install-Module -Name AutomateAPI
Get-InstalledModule -Name AutomateAPI
Import-Module AutomateAPI
Write-Host " Enter Automate Username and Password " -ForegroundColor Green
$AutomateCred = Get-Credential -UserName Vbhatnagar 
Connect-AutomateAPI -Server https://automate.itconnexx.com -Credential $AutomateCred
$link = 'https://sc.itconnexx.com'

#Enter username: automateapi -Enter password: from Passportal

$controlAPICred = Get-Credential -Credential AutomateAPI

# password - APIUser123

#Enter username: automateapi -Enter password: from Passportal
Connect-ControlAPI -Server "$link" -Credential $controlAPICred

#SC address:# https://sc.itconnexx.com 

Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Export-CSV c:\itconnexx-a\AutomateLists.csv

#Check list for number of machines listed

Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Restart

#If the Restart action doesn't fix the issue, trying reinstalling.

#Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Reinstall

<# 

-Ran Import-Module AutomateAPI

-Ran Connect-AutomateAPI

-Enter Automate address: automate.itconnexx.com -Enter Username: automateapi -Enter password: from Passportal

-Connect-ControlAPI

-Enter SC address: https://sc.itconnexx.com 

-Enter username: automateapi -Enter password: from Passportal

-Run: Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Export-CSV c:\itconnexx-a\AutomateLists.csv

-Check list for number of machines listed

-Run: Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Restart

*If the Restart action doesn't fix the issue, trying reinstalling.

Run: Get-AutomateComputer -Online $False | Compare-AutomateControlStatus | Repair-AutomateAgent -Action Reinstall


#>