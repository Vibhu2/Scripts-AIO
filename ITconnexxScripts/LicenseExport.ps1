$clients = Get-MsolPartnerContract -All
 
$msolAccountSkuResults = @()
$msolAccountSkuCsv = "C:\temp\LicenseList.csv"
 
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
 
$msolAccountSkuResults | Select-Object TenantId,CompanyName,PrimaryDomain,AccountSkuId,AccountName,SkuPartNumber,ActiveUnits,WarningUnits,ConsumedUnits,UnusedUnits | Export-Csv -notypeinformation -Path $msolAccountSkuCsv
 
Write-Host "Script complete"