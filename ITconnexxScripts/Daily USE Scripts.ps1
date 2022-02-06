# This Function is to check last Communication of machine from Domain Controller

$computername = "T431S-3"

Function get-computerlastLogon {
  Foreach ($Computer in $Computername) {
    $info = Get-ADComputer -Identity "$Computer" -Properties * | Select-Object -Property Name, SamAccountName, Created, DNSHostName, LastLogonDate, modifyTimeStamp, dSCorePropagationData
    $LastSeenDays = (Get-date) - ($info.lastLogonDate) | Select-Object -Property Days, Hours, Minutes | fl
    $info; $LastSeenDays
    
  }
}
get-computerlastLogon
#______________________________________________________________________________________________________________________

# To Check Disk Space size from Powershell in GB

Function Get-DiskSize {
  $Disks = @()
  $DiskObjects = Get-WmiObject -namespace "root/cimv2" -query "SELECT Name, Capacity, FreeSpace FROM Win32_Volume"
  $DiskObjects | % {
    $Disk = New-Object PSObject -Property @{
      Name           = $_.Name
      Capacity       = [math]::Round($_.Capacity / 1073741824, 2)
      FreeSpace      = [math]::Round($_.FreeSpace / 1073741824, 2)
      FreePercentage = [math]::Round($_.FreeSpace / $_.Capacity * 100, 1)
    }
    $Disks += $Disk
  }
  Write-Output $Disks | Sort-Object Name
}
Get-DiskSize | ft Name, @{L = 'Capacity (GB)'; E = { $_.Capacity } }, @{L = 'FreeSpace (GB)'; E = { $_.FreeSpace } }, @{L = 'FreePercentage (%)'; E = { $_.FreePercentage } }

#Batch File for system Cleanup
<# 
    @echo off
    if not "%1" == "max" start /MAX cmd /c %0 max & exit/b
    echo.
    echo Cleaning system junk files, please wait . . .
    echo.
    del /f /s /q %systemdrive%\*.tmp
    del /f /s /q %systemdrive%\*._mp
    del /f /s /q %systemdrive%\*.log
    del /f /s /q %systemdrive%\*.gid
    del /f /s /q %systemdrive%\*.chk
    del /f /s /q %systemdrive%\*.old
    del /f /s /q %systemdrive%\recycled\*.*
    del /f /s /q %windir%\*.bak
    del /f /s /q %windir%\prefetch\*.*
    rd /s /q %windir%\temp & md %windir%\temp
    del /f /q %userprofile%\cookies\*.*
    del /f /q %userprofile%\recent\*.*
    del /f /s /q “%userprofile%\Local Settings\Temporary Internet Files\*.*”
    del /f /s /q “%userprofile%\Local Settings\Temp\*.*”
    del /f /s /q “%userprofile%\recent\*.*”
    del "%temp%\*.*" /s /q
    FOR /d %%p IN ("%temp%\*.*") DO rd "%%p" /s /q
    cd c:\windows\prefetch
    del *.* /q
    echo.
    echo Junk files clean is finished!
    echo. & pause
#>

$Password = Read-Host -AsSecureString
New-LocalUser -Name "itconnexx-local" -Password "$Password" -PasswordNeverExpires -FullName "Itconnexxadmin" -Description "ITconnexxadmin Account"
Add-LocalGroupMember -Group "Administrators" -Member 'itconnexx-local'

$Password = Read-Host -AsSecureString
New-LocalUser "User03" -Password $Password -FullName "Third User" -Description "Description of this account."