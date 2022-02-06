# Create a Object that contains all the users inside a OU

$UserList= Get-ADUser -Filter * -SearchBase "ou=Shawano,ou=Users,ou=Company,dc=pcitrucks,dc=com"

# Step through Each User in UserList

FOREACH ($User in $UserList) {

Add-ADGroupMember "Application - Procede" -Members $User

}