$UserCredential = Get-Credential -UserName 'acdadmin' 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://autodiscover.alliancebuilds.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential

wget -Uri https://download.microsoft.com/download/e/7/5/e7546cd4-9a64-4644-afdf-01ab02d76fd6/Exchange2019-KB5000871-x64-en.msp -OutFile  C:\MAMP


for (inetilizatio,Condition,){}

Import-Module pswindowsupdate
Get-WindowsUpdate -
