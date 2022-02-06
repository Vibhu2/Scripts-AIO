<#
Script to reset user folder permissions.
Uses: icacls.exe and takeown.exe
Tested on Server 2008 R2 X64
For all folders in base folder:
1. Recursively resets owner to Administrators
2. Reset folder to inherit permissions and apply to subfolders/files, clearing any existing perms
3. Add user (based on folder name) with full control and apply to subfolders/files
4. Recursivley reset owner to user (based on folder name)

Pre-Steps:
1. Populate the $mainDir field below to have the folder location
2. Set the security on the $mainDir folder to your required security (it will be propagated down)
3. Run the script from Powershell by going to the script's root folder and running "./PermissionScript.ps1"
4. If you get an error about script being disabled run:  set-executionpolicy unrestricted
#>

$mainDir = "D:\Profiles"
write-output $mainDir
$dirs = gci "$mainDir" |? {$_.psiscontainer}
foreach ($dir in $dirs){
write-output $dir.fullname
takeown.exe /F $($dir.fullname) /R /D Y |out-null
icacls.exe $($dir.fullname) /reset /T /C /L /Q
icacls.exe $($dir.fullname) /grant ($($dir.basename) + ':(OI)(CI)F') /C /L /Q
icacls.exe $($dir.fullname) /setowner $($dir.basename) /T /C /L /Q
}
