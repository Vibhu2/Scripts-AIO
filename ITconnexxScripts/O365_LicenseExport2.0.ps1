#Find-Module *msonline* | Install-Module -Verbose

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

$clients = Get-MsolPartnerContract -All
 
$msolAccountSkuResults = @()
$msolAccountSkuCsv = "C:\itconnexx-a\iticenseList.csv"
 
ForEach ($client in $clients) {
 
$licenses = Get-MsolAccountSku -TenantId $client.TenantId
 
foreach ($license in $licenses){
 If ($license.SkuPartNumber -ne "POWER_BI_STANDARD" -and
    $license.SkuPartNumber -ne "FLOW_FREE" -and
    $license.SkuPartNumber -ne "POWERAPPS_VIRAL" -and
    $license.SkuPartNumber -ne "TEAMS_COMMERCIAL_TRIAL" -and
    $license.SkuPartNumber -ne "TEAMS_EXPLORATORY" -and
    $license.SkuPartNumber -ne "MICROSOFT_BUSINESS_CENTER" -and
    $license.SkuPartNumber -ne "STANDARDWOFFPACK" -and
    $license.SkuPartNumber -ne "NONPROFIT_PORTAL" -and
    $license.SkuPartNumber -ne "STREAM" -and
    $license.SkuPartNumber -ne "POWER_BI_INDIVIDUAL_USER") {
    $UnusedUnits = $license.ActiveUnits - $license.ConsumedUnits
 
$licenseProperties = @{
TenantId = $client.TenantID
CompanyName = $client.Name
PrimaryDomain = $client.DefaultDomainName
AccountSkuId = $license.AccountSkuId
AccountName = $license.AccountName
SkuPartNumber = $license.SkuPartNumber
ActiveUnits = $license.ActiveUnits
WarningUnits = $license.WarningUnits
ConsumedUnits = $license.ConsumedUnits
UnusedUnits = $unusedUnits
}
 
Write-Host "$($License.AccountSkuId) for $($Client.Name) has $unusedUnits unused licenses"
$msolAccountSkuResults += New-Object psobject -Property $licenseProperties
}
}
 
}
 
 $DifferenceinLiscence = $msolAccountSkuResults | Where-Object -Property UnusedUnits -CGE 1
 $msolAccountSkuResults | Select-Object TenantId,CompanyName,PrimaryDomain,AccountSkuId,AccountName,SkuPartNumber,ActiveUnits,WarningUnits,ConsumedUnits,UnusedUnits | Export-Csv -notypeinformation -Path $msolAccountSkuCsv
 $DifferenceinLiscence | Select-Object CompanyName,AccountSkuId,SkuPartNumber,ActiveUnits,WarningUnits,ConsumedUnits,UnusedUnits | Export-Csv -notypeinformation -Path $msolAccountSkuCsv
 $Results= $DifferenceinLiscence | Select-Object CompanyName,SkuPartNumber,ActiveUnits,ConsumedUnits,UnusedUnits
 $Results | Format-Table -Wrap -AutoSize
 Write-Host " Script completed You Results are saved in your Predefined Location for Later Review " -ForegroundColor Green


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