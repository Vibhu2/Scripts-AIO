Install-Module -Name ExchangeOnlineManagement -RequiredVersion 1.0.1

$company = Get-MsolCompanyInformation -ErrorAction SilentlyContinue

Function checkconnection{
    $company=Get-MsolCompanyInformation -ErrorAction SilentlyContinue
     $result = $?
     return $result
    Write-host -ForegroundColor Cyan " you are connected to ($company.DisplayName)"
}

if (checkconnection) {
   
   
    Write-host -ForegroundColor Cyan you are connected to $company.DisplayName

}

Else{
    write-host Your are not yet connected connecting you to the server -ForegroundColor DarkYellow
    Connect-MsolService -ErrorAction Ignore

}

############################################################################################################################

#Get-MsolPartnerContract -All | Select-Object -Property TenantId,Name,ContractType,DefaultDomainName,ObjectId,PartnerContext
#Get-MsolPartnerContract -All | GM
Function Get-OfficeSyncReport{
            $clients = Get-MsolPartnerContract -All | Select-Object -Property TenantId,Name | Out-GridView -PassThru

            ForEach ($client in $clients) {
            $client | Get-MsolCompanyInformation | Select-Object -Property DisplayName,LastDirSyncTime,LastPasswordSyncTime,PasswordSynchronizationEnabled | format-list
                                                      } 
 }
 ###############################################################################################################################################################

<#https://docs.microsoft.com/en-us/office365/enterprise/powershell/manage-office-365-tenants-with-windows-powershell-for-delegated-access-permissio

Connect-MsolService
Get-MsolPartnerContract -All | Select-Object TenantId
$Tenants = Get-MsolPartnerContract -All; $Tenants | foreach {$Domains = $_.TenantId; Get-MsolDomain -TenantId $Domains | fl @{Label="TenantId";Expression={$Domains}},name}
$Tenants | Format-Table -Property Name,TenantId
Get-MsolUser -TenantID 7c841068-3ad6-4ea6-990a-3d8454a71cbd 
Get-MsolGroup -TenantId 7c841068-3ad6-4ea6-990a-3d8454a71cbd
Get-MsolGroupMember -TenantId 7c841068-3ad6-4ea6-990a-3d8454a71cbd -GroupObjectId 034e3735-fa0e-42c2-b571-bebe1cc4ffa1
#>


Get-exoMailbox -ResultSize Unlimited | Where {$_.name -NotLike ‘*DiscoverySearchMailbox*’} | Sort Alias | Select UserPrincipalName, DisplayName,Name, Alias,RecipientTypeDetails, EmailAddresses, PrimarySmtpAddress | Format-table -Wrap -AutoSize