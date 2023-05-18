$DomainSuffix = "aaccreditunion.mail.onmicrosoft.com"
Get-ADUser -Filter 'Enabled -eq "True"' -SearchBase "OU=Disabled Users,OU=Users,OU=MyBusiness,DC=internal,DC=aaccreditunion,DC=org" |


ForEach {

    Set-ADUser $_.SamAccountName -Add @{ProxyAddresses="smtp:$($_.SamAccountName)@$DomainSuffix"}
	Write-Host Adding proxy address for ($_.SamAccountName)
}