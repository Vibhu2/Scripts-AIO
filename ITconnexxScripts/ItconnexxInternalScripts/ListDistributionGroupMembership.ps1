Import-Module ActiveDirectory
Get-ADGroup -filter "Groupcategory -eq 'Distribution' -AND GroupScope -ne 'DomainLocal' -AND Member -like '*'" |
foreach { 
 Write-Host "Exporting $($_.name)" -ForegroundColor Cyan
 $name = $_.name -replace " ","-"
 $file = Join-Path -path "C:\work" -ChildPath "$name.csv"
 Get-ADGroupMember -Identity $_.distinguishedname -Recursive |  
 Get-ADObject -Properties SamAccountname,Title,Department |
 Select Name,DistinguishedName,ObjectClass |
 Export-Csv -Path $file -NoTypeInformation
}