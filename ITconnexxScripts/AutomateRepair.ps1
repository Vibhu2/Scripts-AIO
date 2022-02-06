Start-BitsTransfer -Source "https://dl5.filehippo.com/c28/a39/b75e175ec1b33d1504db7640fe6a540a97/TeamViewer_Setup.exe?Expires=1632462744&Signature=fd274b5ac5336602ad2e52ad2c4476c3ba78edfd&url=https://filehippo.com/download_teamviewer/&Filename=TeamViewer_Setup.exe" -Destination C:\itconnexx\teamviewer.exe

Get-Service | Where-Object {($_.StartType -ilike "Automatic") -and ($_.Status -ilike "stopped")}

Get-Service -Name BITS
Get-Process -Name pwsh