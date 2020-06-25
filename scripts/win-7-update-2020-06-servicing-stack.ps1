New-Item -Path "C:\" -Name "Updates" -ItemType Directory

Write-Host "$(Get-Date -Format G): Downloading June 2020 Servicing Stack Update for Windows 7"
(New-Object Net.WebClient).DownloadFile("http://download.windowsupdate.com/c/msdownload/update/software/secu/2020/05/windows6.1-kb4562030-x64_bdaf160cd4ae7ff65ce1cfb01fcd645bfb2d75bd.msu", "C:\Updates\windows6.1-kb4562030-x64.msu")

$kbid="windows6.1-kb4562030-x64"
$update="June 2020 Servicing Stack Update for Windows 7"

Write-Host "$(Get-Date -Format G): Extracting $update"
Start-Process -FilePath "wusa.exe" -ArgumentList "C:\Updates\$kbid.msu /extract:C:\Updates" -Wait

Write-Host "$(Get-Date -Format G): Installing $update"
Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\$kbid.cab /quiet /norestart /LogPath:C:\Windows\Temp\$kbid.log" -Wait

Remove-Item -LiteralPath "C:\Updates" -Force -Recurse
Write-Host "$(Get-Date -Format G): Finished installing $update. The VM will now reboot and continue the installation process."