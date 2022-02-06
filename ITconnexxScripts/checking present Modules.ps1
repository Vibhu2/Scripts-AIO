$onlineversion = (Find-Module AutomateAPI)
$localModule = Get-InstalledModule -Name AutomateAPI
if ( $onlineversion.Build -eq $localModule.build ){
 
 Write-Host  module is updated

}elseif ($onlineversion.Build -gt $localModule.build) {

    Write-host Updated Module Found Updating local copy

    Find-Module "AutomateAPI" | Install-Module -Force -Verbose

}elseif($onlineversion.Build -inotlike $localModule ) {

    Write-Host Module not found installing Module
 
 Find-Module "AutomateAPI" | Install-Module -Force -Verbose

}


#if( $localModule = 0 ) {Find-Module "AutomateAPI" | Install-Module -Force -Verbose}


if (Get-InstalledModule -Name AutomateAPI) {
    Write-Host "Module exists" -ForegroundColor Green
} 
else{
    Write-Host "Module does not exist" -ForegroundColor Red
    Write-Host " Installing Module " -ForegroundColor Green
    Find-Module "AutomateAPI" | Install-Module -Force -Verbose
}
else{
  
  Write-host Your Module is ot of date Updating Module -ForegroundColor Red
  Write-Host Updating your Module -ForegroundColor Green
  Update-Module -Name AutomateAPI -Force 
}

Uninstall-Module -Name AutomateAPI
Get-InstalledModule AutomateAP
