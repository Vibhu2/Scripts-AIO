#1) Write a script to findout  age of pereson with Powershell Script [static script] (hint: Get-date)
            Write-Host " This is a Small Program to calculate your Age n Days and Years" -ForegroundColor Green
            Write-Host "Please enter your date of birth in MM(Month in 2 digits)/dd (Date in 2 digit format)/yyyy (Year in full 4 digit format) format" -BackgroundColor Blue
            [datetime]$DateOfBirth= Read-Host 
            $Birthday = get-date -Date $DateOfBirth
            $AgeInDays = ((get-date)-($Birthday)).totalDays
            $Days=[math]::Round($AgeInDays)
            #$Days
            $years= $days/365
            $Totalyears = [Math]::Round($years)
            #$Totalyears
            Write-Host "You are $Days days old" -ForegroundColor Black  " or you are $Totalyears Experienced :)" -BackgroundColor yellow 



#2) Write a Script to findout Multiplication of any two numbers[ values should be provided at runtime of only]
[int]$Number1 = Read-Host -Prompt "Please enter First integer of your choice for multiplication" 
[int]$Number2 = Read-Host -Prompt "Please enter second integer of your choice for multiplication" 
[Int]$Results =  ( $Number1*$Number2)
Write-host - Result of Multiplication of $Number1 and $Number2 is $Results -BackgroundColor Cyan -ForegroundColor Black

#3)Write a script delete all the files which are older than 30 days.
Get-ChildItem -Path D:\  -Recurse | Where-Object {$_.LastWriteTime -gt ((get-date).AddDays(-30))} | Remove-Item -WhatIf
<#4) How to store a command/expression output into one varaible. Give an example.
   if i want sent another command's  output to same file, how to do it?
   #>
   Get-Process | Out-File -FilePath D:\file.txt
   Get-Service | Out-File -FilePath D:\file.txt -Append

<#5) Write a script with two user's input(i.e, starting num and ending num).
    After that, print all the numbers which are multiples of 5.
   ex : Starting : 100	, ending: 123
   Result should be:            100,105,110,115,120
#>
Write-Host " A program to find out multiples of 5 between a given range of number "
 Write-Host " Enter first  number of your choice "
$number2 = Read-Host " Enter the first number of your choice"
$number1 = Read-Host "Enter second Number of your choice"
   #################################################################################################

   $Number = 13.5
   [math]::Truncate($Number)
   [math]::Floor($Number)
   [math]::Floor($Number)
   [math]::ceiling($Number)
   [math]::Round($Number)



  
  


