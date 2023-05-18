
param(

  [Parameter(
    Mandatory = $false,
    HelpMessage = "Get (only) Shared Mailboxes or not. Default include them"
  )]
  [ValidateSet("no", "only", "include")]
  [string]$sharedMailboxes = "include",

  [Parameter(
    Mandatory = $false,
    HelpMessage = "Include Archive mailboxes"
  )]
  [switch]$archive = $true,

  [Parameter(
    Mandatory = $false,
    HelpMessage = "Enter path to save the CSV file"
  )]
  [string]$path = "$ENV:userprofile\downloads\Mailbox_Report-$((Get-Date -format "MMM-dd-yyyy").ToString()).csv"
)

Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

Function Get-Mailboxes {

  process {
    switch ($sharedMailboxes)
    {
      "include" {$mailboxTypes = "UserMailbox,SharedMailbox"}
      "only" {$mailboxTypes = "SharedMailbox"}
      "no" {$mailboxTypes = "UserMailbox"}
    }

    Get-Mailbox -ResultSize unlimited | 
      select UserPrincipalName, DisplayName, PrimarySMTPAddress, RecipientType, RecipientTypeDetails, IssueWarningQuota, ProhibitSendReceiveQuota, ArchiveQuota, ArchiveWarningQuota, ArchiveDatabase
  }
}

Function ConvertTo-Gb {
  <#
    .SYNOPSIS
        Convert mailbox size to Gb for uniform reporting.
  #>
  param(
    [Parameter(
      Mandatory = $true
    )]
    [string]$size
  )
  process {
    if ($size -ne $null) {
      $value = $size.Split(" ")

      switch($value[1]) {
        "GB" {$sizeInGb = ($value[0])}
        "MB" {$sizeInGb = ($value[0] / 1024)}
        "KB" {$sizeInGb = ($value[0] / 1024 / 1024)}
      }

      return [Math]::Round($sizeInGb,2,[MidPointRounding]::AwayFromZero)
    }
  }
}


Function Get-MailboxStats {
  <#
    .SYNOPSIS
        Get the mailbox size and quota
  #>
  process {
    $mailboxes = Get-Mailboxes
    $i = 0

    $mailboxes | ForEach {

      # Get mailbox size     
      $mailboxSize = Get-MailboxStatistics -identity $_.UserPrincipalName | Select TotalItemSize,TotalDeletedItemSize,ItemCount,DeletedItemCount,LastUserActionTime

      if ($mailboxSize -ne $null) {
      
        # Get archive size if it exists and is requested
        $archiveSize = 0
        $archiveResult = $null

        if ($archive.IsPresent -and ($_.ArchiveDatabase -ne $null)) {
          $archiveResult = Get-MailboxStatistics -UserPrincipalName $_.UserPrincipalName -Archive | Select ItemCount,DeletedItemCount,@{Name = "TotalArchiveSize"; Expression = {$_.TotalItemSize.ToString().Split("(")[0]}}
          if ($archiveResult -ne $null) {
            $archiveSize = ConvertTo-Gb -size $archiveResult.TotalArchiveSize
          }else{
            $archiveSize = 0
          }
        }  
    
        [pscustomobject]@{
          "Display Name" = $_.DisplayName
          "Email Address" = $_.PrimarySMTPAddress
          "Mailbox Type" = $_.RecipientTypeDetails
          "Last User Action Time" = $mailboxSize.LastUserActionTime
          "Total Size (GB)" = ConvertTo-Gb -size $mailboxSize.TotalItemSize.ToString().Split("(")[0]
          "Deleted Items Size (GB)" = ConvertTo-Gb -size $mailboxSize.TotalDeletedItemSize.ToString().Split("(")[0]
          "Item Count" = $mailboxSize.ItemCount
          "Deleted Items Count" = $mailboxSize.DeletedItemCount
          "Mailbox Warning Quota (GB)" = $_.IssueWarningQuota.ToString().Split("(")[0]
          "Max Mailbox Size (GB)" = $_.ProhibitSendReceiveQuota.ToString().Split("(")[0]
          "Archive Size (GB)" = $archiveSize
          "Archive Items Count" = $archiveResult.ItemCount
          "Archive Deleted Items Count" = $archiveResult.DeletedItemCount
          "Archive Warning Quota (GB)" = $_.ArchiveWarningQuota.ToString().Split("(")[0]
          "Archive Quota (GB)" = ConvertTo-Gb -size $_.ArchiveQuota.ToString().Split("(")[0]
        }

        $currentUser = $_.DisplayName
        Write-Progress -Activity "Collecting mailbox status" -Status "Current Count: $i" -PercentComplete (($i / $mailboxes.Count) * 100) -CurrentOperation "Processing mailbox: $currentUser"
        $i++;
      }
    }
  }
}



# Get mailbox status
Get-MailboxStats | Export-CSV -Path $path -NoTypeInformation

if ((Get-Item $path).Length -gt 0) {
  Write-Host "Report finished and saved in $path" -ForegroundColor Green
}else{
  Write-Host "Failed to create report" -ForegroundColor Red
}