New-Item -Path "C:\" -Name "Updates" -ItemType Directory

Write-Host "Downloading Windows 7 Service Pack 1"
(New-Object Net.WebClient).DownloadFile("https://download.microsoft.com/download/0/A/F/0AFB5316-3062-494A-AB78-7FB0D4461357/windows6.1-KB976932-X64.exe", "C:\Updates\windows6.1-KB976932-X64.exe")

Write-Host "Installing Windows 7 Service Pack 1"
Start-Proces -FilePath "C:\Updates\Windows6.1-KB976932-X64.exe" -ArgumentList "/unattend /nodialog /norestart" -Wait

Write-Host "Downloading April 2015 Servicing Stack Update for Windows 7"
(New-Object Net.WebClient).DownloadFile("https://download.microsoft.com/download/5/D/0/5D0821EB-A92D-4CA2-9020-EC41D56B074F/Windows6.1-KB3020369-x64.msu", "C:\Updates\Windows6.1-KB3020369-x64.msu")

Write-Host "Installing April 2015 Servicing Stack Update for Windows 7"
Start-Process -FilePath "wusa.exe" -ArgumentList "C:\Updates\Windows6.1-KB3020369-x64.msu /quiet /norestart"

Write-Host "Downloading Convenience rollup update for Windows 7"
(New-Object Net.WebClient).DownloadFile("http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/05/windows6.1-kb3125574-v4-x64_2dafb1d203c8964239af3048b5dd4b1264cd93b9.msu", "C:\Updates\windows6.1-kb3125574-v4-x64.msu")

Write-Host "Installing Convenience rollup update for Windows 7"
Start-Process -FilePath "wusa.exe" -ArgumentList "C:\Updates\windows6.1-kb3125574-v4-x64.msu /quiet /norestart"

Remove-Item -LiteralPath "C:\Updates" -Force -Recurse
