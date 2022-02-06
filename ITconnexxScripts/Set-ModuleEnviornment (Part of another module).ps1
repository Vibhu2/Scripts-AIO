Function Set-enviornment {

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


