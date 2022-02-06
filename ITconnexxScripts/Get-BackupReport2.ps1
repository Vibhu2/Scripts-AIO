function Get-report{  
    
    $WantFile1 = "X:\SCBackups"
    $WantFile2 = "F:\SCBackups"
    $WantFile3 = "X:\VolumeImages"
    $WantFile4 = "C:\ESD"
    $FileExists1 = Test-Path $WantFile1
    $FileExists2 = Test-Path $WantFile2
    $FileExists3 = Test-Path $WantFile3
    $FileExists4 = Test-Path $WantFile4
    If ($FileExists1 -eq $True) {$path ="X:\SCBackups"}
    ElseIf ($FileExists2 -eq $True) {$Path = "F:\SCBackups"}
    ElseIf ($FileExists3 -eq $True) {$Path = "X:\VolumeImages"}
    ElseIf ($FileExists4 -eq $True) {$Path = "C:\ESD"}
    Else {$Path = "No file at Any location"}
    $WantFile2 = "F:\SCBackups"

    $folders = gci $path | where psiscontainer | select Fullname, LastWriteTime
    foreach($folder in $folders){
        $start = ([datetime]$folder.LastWriteTime).AddMinutes(-30)
        $obj=Get-ChildItem -Path $folder.fullname -Include *.spi,*.SPF,*.sp,*.txt -Recurse | Where-Object {$_.lastWritetime -gt $start} | Sort-Object -Property LastWriteTime -Descending | Select-Object -Property Name,Directory,LastWriteTime
        $unique = $obj | select @{n='n';e={($_.name -split "_")[0]}} | % n | select -Unique
        foreach($u in $unique){
                $obj | Where Name -like "$u*" | Select-Object -First 1
        }

    }

    

    }
   $r= get-report 
   $r | clip.exe
   $r


_________________________________________________________________________________________________________________________________________________

function Get-report{  
    
    $path="C:\Downloads"
    $folders = gci $path | where psiscontainer | select Fullname, LastWriteTime
    foreach($folder in $folders){
        $start = ([datetime]$folder.LastWriteTime).AddMinutes(-30)
        $obj=Get-ChildItem -Path $folder.fullname -Include *.spi,*.SPF,*.sp,*.txt -Recurse | Where-Object {$_.lastWritetime -gt $start} | Sort-Object -Property LastWriteTime -Descending | Select-Object -Property Name,Directory,LastWriteTime
        $unique = $obj | select @{n='n';e={($_.name -split "_")[0]}} | % n | select -Unique
        foreach($u in $unique){
                $obj | Where Name -like "$u*" | Select-Object -First 1
        }

    }

    

    }
   $r= get-report 
   $r | clip.exe
   $r