#Restart and Wait
Restart-Computer -Wait -Force -ComputerName $Server
Get-WmiObject -class  win32_operatingsystem -ComputerName $server
######################################################################################################################
workflow test-restart {
    param (
    )
    Get-WmiObject -ClassName win32_Computersystem  | out-file -FilePath C:\Intel\report.txt
    (get-date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime | Out-File C:\Intel\bootup1.txt
    Get-Service | Out-File C:\Intel\service.txt
    Restart-Computer -Wait -Force
    Get-WmiObject -ClassName win32_Computersystem  | out-file -FilePath C:\Intel\report2.txt   
    Get-CimInstance Win32_OperatingSystem | Select-Object PSComputerName, LastBootUpTime, LocalDateTime | Out-File -FilePath C:\Intel\boottime.txt
    (get-date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime | Out-File C:\Intel\bootup2.txt

}
######################################################################################################################
Import-Module PSWorkflow
workflow Test-Workflow {
    $a = 1
    $a
    $a++
    $a
    $b = $a + 2
    $b
}
Test-Workflow

######################################################################################################################
Import-Module PSWorkflow
workflow Test-Workflow {
    InlineScript {
        $obj = New-Object -TypeName PSObject
        $obj | Add-Member -MemberType NoteProperty `
            -Name ExampleProperty `
            -Value 'Hello!'
        $obj | Get-Member
    }
}
Test-Workflow

function FunctionName {
    param (
        OptionalParameters
    )
}




(get-date) - (Get-CimInstance Win32_OperatingSystem ).LastBootUpTime

get-date | GM

(Get-Date).AddDays( -1) 

$serviceStatus = Get-Service  -Name "windows update"
Write-Host " Current status of Service (($serviceStatus).Name) is (($serviceStatus).status)" -ForegroundColor Green
if ( $serviceStatus.status -eq "Running"){

    Write-host " we are stopping the service as it was Running "
    $serviceStatus | Stop-Service -PassThru

}
else {
    $serviceStatus | Start-Service -PassThru
}

__________________________________________________________________________________________________

$folder= "C:\Windows"
if (Test-Path -Path $folder){
 Write-Host "Your folder exist" -ForegroundColor Green
}

switch (3)
    {
        1 {"It is one."}
        2 {"It is two."}
        3 {"It is three."}
        3 {"It is four."}
    }
