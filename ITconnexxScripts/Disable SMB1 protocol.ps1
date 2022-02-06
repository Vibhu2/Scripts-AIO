$OSNAME=(Get-WmiObject -Class Win32_operatingsystem).caption

If ($OSNAME -match "10"-or $OSNAME-match "8.1" -or $OSNAME -match "2019" -or $osname -match "2016" -or $OSNAME -match "2012 R2"){
    
    Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol

}

elseif($OSNAME -match "8" -or $osname -match "2012" ){

    
    Set-SmbServerConfiguration -EnableSMB1Protocol $false

}

Elseif ($OSNAME -match "7" -or $OSNAME -match "2008 R2" -or $OSNAME -match "Vista" -or $OSNAME -match "2008"){

    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" SMB1 -Type DWORD -Value 0 -Force

}

Else{

    CMD
    sc.exe config lanmanworkstation depend= bowser/mrxsmb20/nsi
    sc.exe config mrxsmb10 start= disabled

}
