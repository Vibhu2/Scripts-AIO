Function Get-RDSLiscenceSummery {

                $fileName = (Invoke-WmiMethod Win32_TSLicenseReport -Name GenerateReportEx).FileName
                $summaryEntries = (Get-WmiObject Win32_TSLicenseReport|Where-Object FileName -eq $fileName).FetchReportSummaryEntries(0,0).ReportSummaryEntries
                #$summaryEntries|ForEach {Write-Host $_.ProductVersion $_.TSCALType "Installed:" $_.InstalledLicenses "Issued:" $_.IssuedLicenses}
                #$remainingLiscences = $summaryEntries { "$_.InstalledLicenses" - "$_.IssuedLicenses " }
                $installedLicenses = $summaryEntries.InstalledLicenses
                $IssuedLicenses = $summaryEntries.IssuedLicenses
                $remainingLicenses = ("$installedLicenses" - "$IssuedLicenses")
                $Domain = (Get-WmiObject Win32_ComputerSystem).Domain
                Write-host client information Domain:- $Domain
                Write-host RDS server Name:- $env:COMPUTERNAME
                Write-host "Installed Licenses on server are: $installedLicenses"
                Write-host "Issues Licenses on RDS server are: $IssuedLicenses"
                Write-host "Remaining RDS Licenses are: $remainingLicenses" -ForegroundColor Cyan

}