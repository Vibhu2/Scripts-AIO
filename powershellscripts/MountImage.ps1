$MountPath = “X:\DISM\TempMount\Mount”
$WimFile = “X:\Imaging\DeploymentShare\Operating Systems\Windows 10 Pro\sources\install.wim”
DISM /Mount-Wim /WimFile:$WimFile /index:6 /Mountdir:$MountPath
DISM /Unmount-Wim /Mountdir:$MountPath /commit
DISM /Cleanup-Wim