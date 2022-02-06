# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV C:\UserImport\KSDStudents.csv

# Step through Each Item in the List

FOREACH ($Person in $UserList) {

# Build Username

$Username=$Person.SamAccountName

# Build Password

$Password=$Person.Password

# Build the Displayname

$Name=$Person.DisplayName

# Build and define Domain name

$Domain="@kewaunee.k12.wi.us"

# Build User Principal Name

$UPN=$Username+$Domain

# Build and define Home Directory path

$HDrive=$Person.HomeDirectory

# Build and define which Organizational Unit to create User inside

$OU=$Person.Path

# Create Account in Active Directory (AND HERE...WE...GO!)

New-ADUser -Name $Name –GivenName $Person.GivenName –Surname $Person.Surname –DisplayName $Name –SamAccountName $Username -Description "Import" -ChangePasswordAtLogon $false -HomeDrive "U:" -HomeDirectory $HDrive –UserPrincipalName $UPN -Path $OU

# Build and Add User to Security Groups

Start-Sleep -s 10

Add-ADPrincipalGroupMembership -Identity $Username -MemberOf "APP-MicroPacePro", "APP-MicroTypePro", "KSD-Students", "Password-Student"

# Set Password

Set-ADAccountPassword -Identity $Username -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)

# Enable Account

Enable-ADAccount -Identity $Username

# Check for User's Home Drive and create if not one.  Also adds permissions

Start-Sleep -s 10

if (-not (Test-Path $HDrive)) { 
    $acl = (md $HDrive).GetAccessControl()
    $perm = $UserName,"Modify","ContainerInherit,ObjectInherit","None","Allow"
    $accessRule = new-object System.Security.AccessControl.FileSystemAccessRule $perm
	$acl.SetAccessRule($accessRule)
	$acl | Set-Acl -Path $HDrive
   }
}