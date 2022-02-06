# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV C:\Temp\Users.csv -header("name","username")

# Step through Each Item in the List

FOREACH ($User in $UserList) {

Add-ADGroupMember "Email Disclaimer" -Members $User.username

}