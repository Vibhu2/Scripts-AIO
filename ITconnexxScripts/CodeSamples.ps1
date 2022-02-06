$username = "vbhatnagar@itconnexx.com"
$password = ConvertTo-SecureString "C0mpl3xP@ssw0rd!!" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Import-Module MSOnline
Connect-MSolService -Credential $psCred
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection 
Import-PSSession $Session -AllowClobber -DisableNameChecking

#___________________________________________________________________________________________________

# saving and using passwords in script

$username = "admin@domain.com"
$password = ConvertTo-SecureString "mypassword" -AsPlainText -Force
$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)
Import-Module MSOnline
Connect-MSolService -Credential $psCred
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell-liveid/ -Credential $psCred -Authentication Basic -AllowRedirection 
Import-PSSession $Session -AllowClobber -DisableNameChecking

#____________________________________________________________________________________________________

$User = "Domain01\User01"
$PWord = ConvertTo-SecureString -String "P@sSwOrd" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord