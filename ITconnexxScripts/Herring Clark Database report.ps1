 Function Get-days{

        #https://devblogs.microsoft.com/scripting/powertip-find-how-many-days-are-in-a-month/
        $currentMonth = (Get-Date).Month
        $NextMonth = ( get-date).Month+1
        $Currentyear= (get-date).Year
        [datetime]::DaysInMonth($Currentyear,$currentMonth)

        
}


#________________________________________________________________________________________________________________________________________________________________________

SELECT DISTINCTROW NewCalls.Date, NewCalls.Time, NewCalls.Attorney, [NewCalls]![FirstName] & " " & [NewCalls]![LastName] AS Expr1, NewCalls.Matter, NewCalls.ReferralType, NewCalls.DirectReferral, Count(NewCalls.NewCallID) AS CountOfNewCallID, NewCalls.Category, NewCalls.Time, NewCalls.Telephone, NewCalls.City, NewCalls.ClientNo
FROM NewCalls
GROUP BY NewCalls.Date, NewCalls.Time, NewCalls.Attorney, [NewCalls]![FirstName] & " " & [NewCalls]![LastName], NewCalls.Matter, NewCalls.ReferralType, NewCalls.DirectReferral, NewCalls.Category, NewCalls.Time, NewCalls.Telephone, NewCalls.City, NewCalls.ClientNo, NewCalls.Time
HAVING (((NewCalls.Date) Between [Enter Beginning Date] And [Enter Ending Date]))
ORDER BY NewCalls.Date, NewCalls.Time, NewCalls.Attorney, NewCalls.Matter;



# Create the Access application object
$Acc = New-Object –Com Access.Application

#Open the database - use full path

$DatabasePath="C:\Users\ITAdmin\Desktop\Testing folder\New1 Calls.mdb"
#$Acc.OpenCurrentDataBase("$DatabasePath")
$Acc.application.OpenCurrentDatabase("$DatabasePath")

#$conn = New-Object System.Data.OleDb.OleDbConnection
#$command = New-Object System.Data.OleD.oledbcommand
$command.connection = $conn
$command = 
" SELECT DISTINCTROW NewCalls.Date, NewCalls.Time, NewCalls.Attorney, [NewCalls]![FirstName] & " " & [NewCalls]![LastName] AS Expr1, NewCalls.Matter, NewCalls.ReferralType, NewCalls.DirectReferral, Count(NewCalls.NewCallID) AS CountOfNewCallID, NewCalls.Category, NewCalls.Time, NewCalls.Telephone, NewCalls.City, NewCalls.ClientNo " & _
" FROM NewCalls" & _
" GROUP BY NewCalls.Date, NewCalls.Time, NewCalls.Attorney, [NewCalls]![FirstName] & " " & [NewCalls]![LastName], NewCalls.Matter, NewCalls.ReferralType, NewCalls.DirectReferral, NewCalls.Category, NewCalls.Time, NewCalls.Telephone, NewCalls.City, NewCalls.ClientNo, NewCalls.Time " & _
" HAVING (((NewCalls.Date) Between [22/11/2020] And [22/12/2020])) " & _
" ORDER BY NewCalls.Date, NewCalls.Time, NewCalls.Attorney, NewCalls.Matter;"

$reader = $command.executereader()

#Run query
$acc.Application.DoCmd.OpenQuery("MonthlyInternetCalls")

#Close database
$acc.Application.CloseCurrentDatabase()

#Close Access
$accessApp.Quit()




$Acc.DoCmd.OpenQuery("")
$Results = $Acc.DoCmd.OpenQuery("Autoamted export")
$Results | Select-Object $Results | Export-Csv -Path C:\Intel";"133992




