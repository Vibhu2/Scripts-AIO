#Place this script on the server with ADUC and run from powershell prompt.
#The script will export a CSV to the C:\ Drive called GroupMember.csv
#Found on the internet by Travis :D


$Groups=Get-DistributionGroup

$Groups| foreach{

$GroupName=$_.Name

$Report+=Get-distributionGroupMember -identity $_.identity| select @{Name='Distribution Group'; Expression={[String]::join(";", $GroupName)}}, Name, PrimarySmtpAddress}

$Report| export-csv "c:\GroupMembers.csv" -notype