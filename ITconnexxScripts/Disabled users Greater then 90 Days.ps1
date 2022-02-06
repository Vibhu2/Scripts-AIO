Search-ADAccount -UsersOnly -AccountInactive -TimeSpan 90.00:00:00 | ?{$_.enabled -eq $false} | %{Get-ADUser $_.ObjectGuid} | Select-Object -Property Name,UserPrincipalName

################################################################################################################################


$disabledUsers=Search-ADAccount -UsersOnly -AccountInactive -TimeSpan 90.00:00:00 | ?{$_.enabled -eq $false} | %{Get-ADUser $_.ObjectGuid}
#$disabledUsers=Search-ADAccount -UsersOnly -AccountInactive -TimeSpan 90.00:00:00 | ?{$_.enabled -eq $false} | %{Get-ADUser $_.ObjectGuid} | Select-Object -Property Name,UserPrincipalName
$disabledUsers.count
$disabledUsers | Move-ADObject -TargetPath "OU=Disabled,OU=Boys & Girls Club,DC=bgcgb,DC=com" -Verbose