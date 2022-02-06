$Mailboxes = Get-Mailbox
$Mailboxes | foreach{ Set-MailboxFolderPermission $($_.UserPrincipalName+":\calendar") -User Default -AccessRights  LimitedDetails}


#Below are the options for AccessRights.  left side is outlook, right side is used above for the script.
# Requested Outlook permissions	      Access rights
#  Free/Busy time	                    AvailabilityOnly
#  Free/Busy time, subject, location	LimitedDetails
#  Reviewer	                            Reviewer
#  Nonediting Author	                NonEditingAuthor
#  Author	                            Author
#  Publishing Author	                PublishingAuthor
#  Editor	                            Editor
#  Publishing Editor	                PublishingEditor
#  Owner	                            Owner


# To spot check your work, you can run:  Get-MailboxFolderPermission -Identity USEREMAIL:\Calendar