#https://devblogs.microsoft.com/scripting/powershell-looping-understanding-and-using-do-while/
$a=1
do
{

"Starting loop $a"
$a
$a++
"Now `$a is $a"


}while( $a -le 10)


Workflow