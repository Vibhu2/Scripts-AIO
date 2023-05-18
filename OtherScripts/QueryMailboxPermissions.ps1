$mbuser = "HumanResources" # <<< Mailbox name to check

$fldList= Get-MailboxFolderStatistics $mbuser -FolderScope Inbox | Select-Object -Property identity | % { $mbuser+":\inbox"+$_.Identity.tostring().trimstart($mbuser) }

# Note this will error out on the inbox\inbox and any folder names with special characters

$fldList|Get-MailboxFolderPermission