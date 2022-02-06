# Import list of Users From CSV into $Userlist

$UserList=IMPORT-CSV C:\ITCONNEXX\ESPMigration\ESPUserImport.csv

# Step through Each Item in the List

FOREACH ($Person in $UserList) {

# Build Username

$Username=$Person.SamAccountName

# Build Password

$Password=$Person.Password

# Build the Displayname

$Name=$Person.DisplayName

# Build the ProxyAddress

$Proxy=$Person.ProxyAddress

# Build and define Domain name

$Domain="@npscorp.com"

# Build User Principal Name

$UPN=$Username+$Domain

# Build Extension Attribute 1

$extensionAttribute1=$Person.extensionAttribute1

# Build and define which Organizational Unit to create User inside

$OU=$Person.Path


# Create Account in Active Directory (AND HERE...WE...GO!)

New-ADUser -Name $Name –GivenName $Person.GivenName –Surname $Person.Surname –DisplayName $Name –SamAccountName $Username -Description "ESP" -ChangePasswordAtLogon $false  –UserPrincipalName $UPN -Path $OU

# Build and Add User to Security Groups

Start-Sleep -s 10

Add-ADPrincipalGroupMembership -Identity $Username -MemberOf "Password Policy - Lock after 5 failed attempts"

# Set Password

Set-ADAccountPassword -Identity $Username -NewPassword (ConvertTo-SecureString -AsPlainText $Password -Force)

# Set Proxy Address

Set-ADUser -Identity $Username -Add @{Proxyaddresses="SMTP:"+$Proxy}

# Set Mail Attribute

Set-ADUser -Identity $Username -EmailAddress $Proxy

# Set Password Never Expires

Set-ADUser -Identity $Username -PasswordNeverExpires:$True

# Set Extension Attribut 1

Set-ADUser -Identity $Username -Add @{extensionAttribute1=$extensionAttribute1}

# Enable Account

Enable-ADAccount -Identity $Username
}