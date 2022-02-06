
#Windows Server 2012 R2, Windows Server 2016, Windows Server 2019 Windows 8.1 and Windows 10 Server Manager method for disabling SMB.

#Detect
Get-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

#Disable
Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol


#Windows 8 and server 2012

#Detect
Get-SmbServerConfiguration | Select EnableSMB1Protocol
#disable
Set-SmbServerConfiguration -EnableSMB1Protocol $false

# Windows 7, Windows Server 2008 R2, Windows Vista, and Windows Server 2008

#Detect
Get-Item HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters | ForEach-Object {Get-ItemProperty $_.pspath}

#Disable
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" SMB1 -Type DWORD -Value 0 -Force
