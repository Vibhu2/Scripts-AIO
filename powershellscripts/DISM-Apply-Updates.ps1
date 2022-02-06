$UpdatesPath = "X:\DISM\Updates\*"
$MountPath = “X:\DISM\TempMount\Mount”
$WimFile = “X:\Imaging\DeploymentShare\Operating Systems\Windows 10 Pro\sources\install.wim”
DISM /Mount-Wim /WimFile:$WimFile /index:6 /Mountdir:$MountPath
$UpdateArray = Get-Item $UpdatesPath
ForEach ($Updates in $UpdateArray)
{
DISM /image:$MountPath /Add-Package /Packagepath:$Updates
Start-Sleep –s 10
}
Write-Host "Updates Applied to WIM"
DISM /Unmount-Wim /Mountdir:$MountPath /commit
DISM /Cleanup-Wim