   if ($TempIEFiles) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 8} 
    if ($Cookies) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 2} 
    if ($History) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 1} 
    if ($FormData) { RunDll32.exe InetCpl.cpl, ClearMyTracksByProcess 16} 
 