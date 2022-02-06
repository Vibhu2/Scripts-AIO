# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV C:\Temp\Users.csv

# Step through Each Item in the List

FOREACH ($User in $UserList) {

Set-ADUser $User.username -EmailAddress $User.Email -Fax $User.Fax -HomePhone $User.Toll -MobilePhone $User.Cell -OfficePhone $User.Direct -Title $User.Title
Add-ADGroupMember $User.group -Members $User.username

}