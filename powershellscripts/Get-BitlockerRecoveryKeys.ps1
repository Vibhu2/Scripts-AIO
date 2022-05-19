<#
	.NOTES
	===========================================================================
	 Created by:   		Vibhu Bhatnagar
	 Created on:        19/5/2022 1:56 PM
	 Created with:   	Visual Studio Code
	 Organization: 		IT By Design India (Chandigarh)
	 Filename:          Get-BitlockerRecoveryKeys
     Client:            Harlin IT
     Ticket:            Service Ticket #2114102 - Bitlocker - Unlock Data drive
	 URL:
	===========================================================================
	.DESCRIPTION
		get-bitlockerUnlockkey diaplays unlock of all the bitlocker locked drives 
#>

function Get-BitlockerUnlockKey{
    [cmdletbinding()]

    
    # Identify all the Bitlocker volumes.
    $BitlockerVolumers = Get-BitLockerVolume

    # For each volume, get the RecoveryPassowrd and display it.
    $BitlockerVolumers |
        ForEach-Object {
            $MountPoint = $_.MountPoint 
            $RecoveryKey = [string]($_.KeyProtector).RecoveryPassword       
            if ($RecoveryKey.Length -gt 5)
            {
                Write-Output ("The drive $MountPoint has a recovery key $RecoveryKey.")
                Write-host "$RecoveryKey"
            }        
        }
}
Get-BitlockerUnlockKey


######################################################################################################
<#
	.NOTES
	===========================================================================
	 Created by:   		Vibhu Bhatnagar
	 Created on:        19/5/2022 2:15 PM
	 Created with:   	Visual Studio Code
	 Organization: 		IT By Design India (Chandigarh)
	 Filename:
     Client:            Harlin IT
	 URL:               https://www.top-password.com/blog/decrypt-bitlocker-encrypted-drive-from-command-line/
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

function Unlock-BitlockerDrive{
    [cmdletbinding()]

    
    # Identify all the Bitlocker volumes.
    $BitlockerVolumers = Get-BitLockerVolume

    # For each volume, get the RecoveryPassowrd and display it.
    $BitlockerVolumers |
        ForEach-Object {
            $MountPoint = $_.MountPoint 
            $RecoveryKey = [string]($_.KeyProtector).RecoveryPassword       
            if ($RecoveryKey.Length -gt 5)
            {
                #Write-Output ("The drive $MountPoint has a recovery key $RecoveryKey.")
                #Write-host "$RecoveryKey"
                manage-bde -unlock $MountPoint -RecoveryKey $RecoveryKey
            }        
        }
}
Unlock-BitlockerDrive

Below are commandlines which can be used to unlock Bitlocker Drive 
# manage-bde -unlock $MountPoint -RecoveryKey $RecoveryKey
# Unlock-BitLocker -MountPoint $MountPoint -RecoveryKeyPath $RecoveryKey


