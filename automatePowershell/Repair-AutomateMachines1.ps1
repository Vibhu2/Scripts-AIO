#Windows update

#link - https://go.microsoft.com/fwlink/?LinkID=799445

Start-BitsTransfer -Source https://go.microsoft.com/fwlink/?LinkID=799445 -Destination C:itconnexx\utility

$password = Read-Host -AsSecureString
New-LocalUser -Name itconnexx-admin -Password $password -as -AccountNeverExpires -PasswordNeverExpires

help New-LocalUser -Examples

$Password = Read-Host -AsSecureString
  New-LocalUser "itconnexx-admin" -Password $Password



  Start-BitsTransfer -Source https://automate.itconnexx.com/LabTech/Deployment.aspx?InstallerToken=ab7f0490fd4341e39731a8ca9ec6bcd0 -Destination  C:\itconnexx-a\utilities\control.msi
