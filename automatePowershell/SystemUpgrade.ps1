#WindowsUpgradeTool

<#

Below are switches available for this executible Windows10Upgrade9252.exe

/Push
/Install
/SetupFile
/SkipSelfUpdate
/ReUseCatalog
/SkipEULA
/OobeUi
/OobeRS2Ui
/EosUi
/PostEosUi
/TenSUi
/PreventWUUpgrade
/SetOobeTourniquetRunningRegKey
/SetPriorityLow
/UninstallUponExit
/UninstallUponUpgrade
/ForceUninstall
/MinimizeToTaskBar
/ShowProgressInTaskBarIcon
/SkipCompatCheck
/QuietInstall
/NoRestartUI
/EnableTelemetry
/InstallationFolder
/Edition
/Language

#>
Start-BitsTransfer -Source https://go.microsoft.com/fwlink/?LinkID=799445 -Destination C:\itconnexx-a\utilities\Windows10Upgrade9252.exe
cd C:\itconnexx-a\utilities\
.\Windows10Upgrade9252.exe /skipeula /Quietinstall /UninstallUponUpgrade /MinimizeToTaskBar /'auto upgrade'
#cmd --% .\Windows10Upgrade9252.exe /quietinstall /skipeula /auto upgrade /UninstallUponUpgrade /MinimizeToTaskBar


<#
Command line Switches available for the WindowsUpdateAssestant.exe are 

CommandLine: [%s]
/InstallFrom
/SessionId
/ClassId
/ReportId
/SuspendId
/CorrelationVector
/FlightData
/Eula
Accept
Defer
/Prompt
/Priority
Normal
/SetupDUPath
/Console
/Selfhost
/Quiet
/ExpressPackage
/Override
/AzureHost
/Update
/Package
/Recovery
/Web
/PreDownload
/Download
/Install
/Finalize
/PostReboot

#>
#WindowsMEdiaCreationTool
Start-BitsTransfer -Source https://go.microsoft.com/fwlink/?LinkId=691209 -Destination C:\itconnexx-a\utilities\WindowsUpdateAssestant.exe

#Note - : Command used to extract the above information is C:\itconnexx-a\utilities>.\strings64.exe .\WindowsUpdateAssestant.exe > .\update.txt


@powershell Start-BitsTransfer -Source https://go.microsoft.com/fwlink/?LinkID=799445 -Destination C:\itconnexx-a\utilities\Windows10Upgrade9252.exe
cd C:\itconnexx-a\utilities\
.\Windows10Upgrade9252.exe /skipeula /Quietinstall /UninstallUponUpgrade /MinimizeToTaskBar /'auto upgrade'

########################################################################################################################################################


@powershell (Get-ComputerInfo).osversion
______________________________________________________________________________________

Start-BitsTransfer -source https://go.microsoft.com/fwlink/?LinkID=799445 -Destination C:\upgradetool.exe
_______________________________________________________________________________________

$Computername = "THINK-E480"
$date=(Get-ADComputer -Identity $Computername -Properties *).LastLogonDate 
$date
(get-date)-$date