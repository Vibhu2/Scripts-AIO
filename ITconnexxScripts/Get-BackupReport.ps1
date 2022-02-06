____________________________________________________________________________________________________________________________________________

function Get-report{  


    $path="X:\SCBackups"
    $folders = gci $path | where psiscontainer | select Fullname, LastWriteTime
    Write-Host number of folders = ($folders.count) -ForegroundColor Yellow
    foreach($folder in $folders){
        $start = ([datetime]$folder.LastWriteTime).Addhours(-24)
        $obj=Get-ChildItem -Path $folder.fullname -Include *.spi,*.SPF,*.sp,*.txt -Exclude Recovery*,SystemReserved*,system* -Recurse | Where-Object {$_.lastWritetime -gt $start} | Sort-Object -Property LastWriteTime -Descending | Select-Object -Property Name,Directory,LastWriteTime
        $unique = $obj | select @{n='n';e={($_.name -split "_")[0]}} | % n | select -Unique
        foreach($u in $unique){
                $obj | Where Name -like "$u*" | Select-Object -First 1
        }

    }

    }
   $r= get-report | Format-Table -HideTableHeaders
   $r | clip.exe
   $r 

   _________________________________________________________________________________________________________________________________________________

   function Get-report{
    $path="X:\SCBackups"
    $start=(get-date).AddHours(-.5)
    #$start=(get-date).AddHours(-24)
    $obj=Get-ChildItem -Path $path -Include *.spi,*.SPF,*.sp -Exclude SystemReserved* -Recurse | Where-Object {$_.lastWritetime -gt $start} | Sort-Object -Property Directory | Sort-Object -Property LastWriteTime -Descending | Select-Object -Property Name,Directory,LastAccessTime
    $obj
    #{(($obj).Name).Substring(0,1) | Select-Object -Unique}.count
    $obj | clip.exe
    }
    get-report | Format-Table -HideTableHeaders
    $r | clip.exe
    #______________________________________________________________________________________________________________________
    function Get-report{  
    
    $WantFile1 = "X:\SCBackups"
    $WantFile2 = "F:\SCBackups"
    $WantFile3 = "X:\VolumeImages"
    $WantFile4 = "C:\ESD"
    $wantfile5 = "E:\SCReplication"
    $wantfile6 = "B:\SCBackups"
    $wantfile7 = "X:\SCReplication"
    $FileExists1 = Test-Path $WantFile1
    $FileExists2 = Test-Path $WantFile2
    $FileExists3 = Test-Path $WantFile3
    $FileExists4 = Test-Path $WantFile4 
    $fileExists5 = Test-Path $wantfile5
    $fileExists6 = Test-Path $wantfile6
    $fileExists7 = Test-Path $wantfile7
    If ($FileExists1 -eq $True) {$Path = "X:\SCBackups"}
    ElseIf ($FileExists2 -eq $True) {$Path = "F:\SCBackups"}
    ElseIf ($FileExists3 -eq $True) {$Path = "X:\VolumeImages"}
    ElseIf ($FileExists4 -eq $True) {$Path = "C:\ESD"}
    ElseIf ($FileExists5 -eq $True) {$Path = "E:\SCReplication"}
    ElseIf ($FileExists6 -eq $True) {$Path = "B:\SCBackups"}
    ElseIf ($FileExists7 -eq $True) {$Path = "X:\SCReplication"}
    Else {$Path = "No file at Any location"}
    # code written from line one till this point is just to select correct path for variable $path#
    #$WantFile2 = "F:\SCBackups"

    #$folders = Get-ChildItem $Path | Where.psiscontainer | select Fullname, LastWriteTime
    #$folders = Get-ChildItem $Path | (Where-Object)psiscontainer | Select-Object -Property Fullname, LastWriteTime
    $folders = Get-ChildItem $Path | Select-Object -Property Fullname, LastWriteTime
    Write-Host number of folders = ($folders).count -ForegroundColor Cyan
    $InactiveFolder = (Get-ChildItem -Path $Path -Directory | Where-Object {$_.LastWriteTime -ile (Get-Date).AddDays(-2)})
    $InactiveFolder  | Write-Host -ForegroundColor Red
    #write-host "Number of Backup Images" = ($r).count -ForegroundColor Yellow

    foreach($folder in $folders){
        $start = ([datetime]$folder.LastWriteTime).Addhours(-24)
        $obj=Get-ChildItem -Path $folder.fullname -Include *.spi,*.SPF,*.sp -Exclude SystemReserved*,Recovery*,system* -Recurse | Where-Object {$_.lastWritetime -gt $start} | Sort-Object -Property LastWriteTime -Descending | Select-Object -Property Name,Directory,LastWriteTime
        $unique = $obj | select @{n='n';e={($_.name -split "_")[0]}} | % n | select -Unique
        foreach($u in $unique){
                $obj | Where Name -like "$u*" | Select-Object -First 1
        }

    }

        write-host "Number of Backup Images" = ($r).count -ForegroundColor Yellow

    }
   $r = get-report 
   $r | Format-Table -AutoSize -HideTableHeaders | clip.exe  
   $r




install-module PSWindowsUpdate -forcedownload
Set-ExecutionPolicy -ExecutionPolicy Unrestricted 
Install-WindowsUpdate -AcceptAll -Verbose

