

$File= Get-Content C:\itconnexx-a\list.txt

foreach ($f in $File) {

Get-ChildItem *$f* | Copy-Item -Destination X:\HRLDC1 -verbose

}