
Test-Path -Path "$env:HOMEDRIVE\Program Files (x86)\Bleachbit\BleachBit-Portable\bleachbit_console.exe"
Remove-Item -Path "$env:HOMEDRIVE\Program Files (x86)\Bleachbit" -Recurse -Force
New-Item -Path "$env:HOMEDRIVE\Program Files (x86)\Bleachbit" -ItemType Directory
$Location= "$env:HOMEDRIVE\Program Files (x86)\Bleachbit"
$filename='BleachBit-4.2.0-portable.zip'
$programfiles='$env:HOMEDRIVE\Program Files (x86)\Bleachbit\BleachBit-Portable\bleachbit_console.exe'
$program= '$env:HOMEDRIVE\Program Files (x86)\Bleachbit\BleachBit-Portable\'

Function Download-Presequits{

$url ='https://drive.google.com/uc?export=download&id=1YmFxqSlRF0cH9h_LEK5iBDHgQJeBanJA'
$output = "$Location\$filename"
$Programpath="$Location\$filename"
Invoke-WebRequest -UseBasicParsing $url -OutFile $output
Expand-Archive -Path $Location\$filename -DestinationPath $Location

}


Function Set-CleaningPreferences{

$program= "$env:HOMEDRIVE\Program Files (x86)\Bleachbit\"
Set-Location $program
#$exe = ".\bleachbit.exe"
$Console= ".\bleachbit_console.exe"
&$console --gui --no-uac --update-winapp2

}

Function Set-CleaningPreferences{

$program= "$env:HOMEDRIVE\Program Files (x86)\Bleachbit\BleachBit-4.2.0-portable\BleachBit-Portable"
Set-Location $program
#$exe = ".\bleachbit.exe"
$Console= ".\bleachbit_console.exe"
&$console --gui 

}

Function Get-Drivespace {

Get-WmiObject -Class Win32_logicaldisk -Filter "DriveType = '3'" | 
Select-Object -Property DeviceID, DriveType, VolumeName, 
@{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}},
@{L="Capacity";E={"{0:N2}" -f ($_.Size/1GB)}}
}

Function Remove-Files{
    $program= "$env:HOMEDRIVE\Program Files (x86)\Bleachbit\BleachBit-4.2.0-portable\BleachBit-Portable"
    #$Programpath="C:\Users\Vibhu\Downloads\BleachBit-Portable"
    Set-Location $program
    $Console= ".\bleachbit_console.exe"
    &$console --preset --clean --no-uac
}


#start-job -sciptblock { Download-Presequits -Name 'BBDownload'}
#Start-Job -ScriptBlock { Download-Presequits -Name 'BBDownload'}
#Get-Job
#Wait-Job -Name 'BBDownload'
#Remove-Files



Download-Presequits
Remove-Files

.\bleachbit_console.exe --no-uac --preset --systeminfo --clean
.\bleachbit_console.exe --preset --clean --no-uac