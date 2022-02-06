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

###############################################################################################################################################################


$HJUsers= Get-MsolUser -TenantID 64bbd6bc-29f9-4fa4-8c83-589fcfe87718 -all | Select-Object -Property DisplayName,Department,UserPrincipalName,IsLicensed,LastPasswordChangeTimestamp,WhenCreated | Where-Object {$_.LastPasswordChangeTimestamp -eq $_.WhenCreated -and $_.IsLicensed -eq $true} | Format-Table
$HJUsers
#Get-MsolUser -TenantID 64bbd6bc-29f9-4fa4-8c83-589fcfe87718 -all | Select-Object -Property DisplayName,IsLicensed,LastPasswordChangeTimestamp,WhenCreated | Where-Object {$_.LastPasswordChangeTimestamp -eq $_.WhenCreated -and $_.IsLicensed -eq $true} |Sort-Object -Property Displayname 

Get-MsolUser -TenantID 64bbd6bc-29f9-4fa4-8c83-589fcfe87718 -MaxResults 20 | Select-Object -Property DisplayName,Department,UserPrincipalName,IsLicensed,LastPasswordChangeTimestamp,WhenCreated | Where-Object {$_.LastPasswordChangeTimestamp -eq $_.WhenCreated -and $_.IsLicensed -eq $true} | Format-Table

Get-MsolUser -TenantID 64bbd6bc-29f9-4fa4-8c83-589fcfe87718 -MaxResults 100 | Select-Object -Property DisplayName,Department,UserPrincipalName,AlternateEmailAddresses,ProxyAddresses | Format-Table -AutoSize

Get-MsolUser -TenantID 64bbd6bc-29f9-4fa4-8c83-589fcfe87718 -MaxResults 100 AlternateEmailAddresses | Format-Table -Property DisplayName,UserPrincipalName,ProxyAddresses,AlternateEmailAddresses | Format-Table -Property * -AutoSize | Out-String -Width 4096 `
| Out-File C:\itconnexx-a\report.txt

