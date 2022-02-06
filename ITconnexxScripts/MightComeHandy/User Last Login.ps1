$Path = 'C:\Temp\LastLogon.csv' 
Get-ADUser -Filter {enabled -eq $true} -Properties LastLogonTimeStamp | 

Select-Object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('yyyy-MM-dd_hh:mm:ss')}} | Export-Csv -Path $Path –notypeinformation

___________________________________________________________________________________________________________________________________________________________________________________________

Get-ADUser -Filter {enabled -eq $true} -Properties LastLogonTimeStamp | 

Select-Object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp).ToString('dd-MM-yyyy_hh:mm:ss')}}