# **********************************************************
# * Scriptname:Exch-MailboxGUIDSync.ps1
# * Author: Damon Fischer
# * Purpose: Syncs MailboxGUID attribute from Exchange Online to Active Directory user objects
# * Usage:
# * Change History
# * 7/19/2016	Damon Fischer	Created Script 
# * 
# * 
# * Notes: 
# * After Exchange 2013 CU 12 admin will get a 500 error opening the ECP if msexchmailboxguid is not configured on their local AD account
# **********************************************************

[datetime]$starttime=Get-Date

$ErrorCount = 0
$AddCount = 0

if(!(Test-Path -Path .\Logs )){
    New-Item -ItemType directory -Path .\Logs
}	
$logfilename=".\Logs\Exch-MailboxGUIDSync-Log" + (get-date -uformat "%Y-%m-%d") + ".txt"
write-host "Logging output to file " + $logfilename

#Verify powershell version
If ($PSVersionTable.PSVersion.Major -lt 4){
	Write-Warning "This script has only been tested on powershell version 4 . . . Exiting Script"
	Exit 1
}

#Command to load encrypted credential file  (Make sure to be logged in with the accout that will be executing the script)
#Get-Credential "EXCHSCRIPTS@YourDomain.com" | Export-Clixml C:\scripts\creds\ExchScripts.xml

write-host "Connecting to On-Prem Exchange . . ."
try {
	$ExchCred = Get-Credential
	$SessionOPExch = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://fetzer-exch01.fetzer.local/PowerShell/ -Authentication Default -Credential $ExchCred
	Import-PSSession $SessionOPExch -AllowClobber
	}
catch {
	write-output ("Error connecting to On Prem Exchange . . . Exiting Script") | Tee-Object -Append $logfilename
	write-output ("Error Message:" + $_.Exception.Message ) | Tee-Object -Append $logfilename
	#write-output ("Error Message to string:" + $_.Exception.ToString() ) | Tee-Object -Append $logfilename			
	Exit (1)
	}

write-host "Connecting to Exchange Online . . ."
try {
	$cred = Get-Credential
	Connect-MsolService -Credential $cred
	$SessionEXO = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $cred -Authentication Basic -AllowRedirection
	#Import with prefix to avoid conflicts with local Exchange commands 
	Import-PSSession $SessionEXO -Prefix "EXO" # -AllowClobber
	}
catch {
	write-output ("Error connecting to Exchange Online . . . Exiting Script") | Tee-Object -Append $logfilename
	write-output ("Error Message:" + $_.Exception.Message ) | Tee-Object -Append $logfilename
	#write-output ("Error Message to string:" + $_.Exception.ToString() ) | Tee-Object -Append $logfilename			
	Exit (1)
	}


write-host "Getting Remote Mailboxes missing GUID . . ."
try {
	$MBXList = @(get-remotemailbox -Filter {ExchangeGuid -eq '00000000-0000-0000-0000-000000000000'} -ResultSize 500 )
} catch {
	write-output ("Error getting remote mailboxes") | Tee-Object -Append $logfilename
	write-output ("Error Message:" + $_.Exception.Message ) | Tee-Object -Append $logfilename
	#write-output ("Error Message to string:" + $_.Exception.ToString() ) | Tee-Object -Append $logfilename			
	$ErrorCount++
	}


Write-Output "Syncing $($MBXList.count) Mailbox GUIDs" | Tee-Object -Append $logfilename	
Write-Output "===============================================" | Tee-Object -Append $logfilename	


 foreach ($M in $MBXList) {
	Write-Output ("Processing $($M.PrimarySmtpAddress)") | Tee-Object -Append $logfilename	
	$EXOMBX = $null
	try {
		$EXOMBX = Get-EXOMailbox $($M.PrimarySmtpAddress)
		if ($?){
			Write-output ("Successfully found EXO Mailbox $($M.PrimarySmtpAddress)")
		} else {
			throw $error[0].Exception
		}
	} 
	catch {
		write-output ("Error binding to EXO Mailbox $($M.PrimarySmtpAddress)") | Tee-Object -Append $logfilename
		write-output ("Error Message:" + $_.Exception.Message ) | Tee-Object -Append $logfilename
		#write-output ("Error Message to string:" + $_.Exception.ToString() ) | Tee-Object -Append $logfilename			
		$ErrorCount++
		continue
	}
	
	try {
		Set-RemoteMailbox -identity $($M.Identity) -ExchangeGuid ($EXOMBX).ExchangeGuid
		if ($?){
			$AddCount++
		} else {
			throw $error[0].Exception
		}
	} 
	catch {
		write-output ("Error setting GUID on AD Account $($M.PrimarySmtpAddress)") | Tee-Object -Append $logfilename
		write-output ("Error Message:" + $_.Exception.Message ) | Tee-Object -Append $logfilename
		#write-output ("Error Message to string:" + $_.Exception.ToString() ) | Tee-Object -Append $logfilename			
		$ErrorCount++
		continue
	}	
 }

 
#Cleanup Remote Powershell sessions
Remove-PSSession $SessionEXO
Remove-PSSession $SessionOPExch

[datetime]$endtime=Get-Date
$strTimeDiff = new-TimeSpan $startTime $EndTime

write-output ("##################################") | Tee-Object -Append $logfilename
write-output ("END OF SCRIPT" ) | Tee-Object -Append $logfilename
write-output ("$counter record(s) processed. ") | Tee-Object -Append $logfilename
write-output ("Total Number of Adds," + $AddCount) | Tee-Object -Append $logfilename
write-output ("Total Number of Errors," + $ErrorCount) | Tee-Object -Append $logfilename
write-output ("Execution time:{0:dd} days and {0:hh} hours {0:mm} minutes {0:ss} seconds " -f $strTimeDiff) | Tee-Object -Append $logfilename
write-output ("##################################") | Tee-Object -Append $logfilename
