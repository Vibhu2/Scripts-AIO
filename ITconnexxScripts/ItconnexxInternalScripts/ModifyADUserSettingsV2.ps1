# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV C:\Temp\Users.csv

# Step through Each Item in the List

FOREACH ($User in $UserList) {

If (-not $User.HomeDirectory) {}
Else {Set-ADUser $User.SamAccountName -HomeDirectory $User.HomeDirectory}
If (-not $User.ProfilePath) {}
Else {Set-ADUser $User.SamAccountName -ProfilePath $User.ProfilePath}


}