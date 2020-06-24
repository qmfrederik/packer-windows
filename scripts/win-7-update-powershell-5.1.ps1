function Expand-ZIPFile($file, $destination)
{
    $shell = new-object -com shell.application
    $zip = $shell.NameSpace($file)
    foreach($item in $zip.items())
    {
        $shell.Namespace($destination).copyhere($item)
    }
}

New-Item -Path "C:\" -Name "Updates" -ItemType Directory

Write-Host "$(Get-Date -Format G): Downloading Windows Management Framework 5.1"
(New-Object Net.WebClient).DownloadFile("https://download.microsoft.com/download/6/F/5/6F5FF66C-6775-42B0-86C4-47D41F2DA187/Win7AndW2K8R2-KB3191566-x64.zip", "C:\Updates\Win7AndW2K8R2-KB3191566-x64.zip")

Write-Host "$(Get-Date -Format G): Installing Windows Management Framework 5.1"
Expand-ZipFile "C:\Updates\Win7AndW2K8R2-KB3191566-x64.zip" -destination "C:\Updates"

Write-Host "$(Get-Date -Format G): Extracting $update"
Start-Process -FilePath "wusa.exe" -ArgumentList "C:\Updates\Win7AndW2K8R2-KB3191566-x64.msu /extract:C:\Updates" -Wait

Write-Host "$(Get-Date -Format G): Installing $update"
Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\Windows6.1-KB2809215-x64.cab /quiet /norestart /LogPath:C:\Windows\Temp\KB2809215-x64.log" -Wait
Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\Windows6.1-KB2872035-x64.cab /quiet /norestart /LogPath:C:\Windows\Temp\KB2872035-x64.log" -Wait
Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\Windows6.1-KB2872047-x64.cab /quiet /norestart /LogPath:C:\Windows\Temp\KB2872047-x64.log" -Wait
Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\Windows6.1-KB3033929-x64.cab /quiet /norestart /LogPath:C:\Windows\Temp\KB3033929-x64.log" -Wait
Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\Windows6.1-KB3191566-x64.cab /quiet /norestart /LogPath:C:\Windows\Temp\KB3191566-x64.log" -Wait

Write-Host "$(Get-Date -Format G): Update for Windows 7 for x64-based Systems (KB3140245)"
(New-Object Net.WebClient).DownloadFile("hhttp://download.windowsupdate.com/c/msdownload/update/software/updt/2016/04/windows6.1-kb3140245-x64_5b067ffb69a94a6e5f9da89ce88c658e52a0dec0.msu", "C:\Updates\windows6.1-kb3140245-x64.msu")

$kbid="windows6.1-kb3140245-x64"
$update="Update for Windows 7 for x64-based Systems (KB3140245)"

Write-Host "$(Get-Date -Format G): Extracting $update"
Start-Process -FilePath "wusa.exe" -ArgumentList "C:\Updates\$kbid.msu /extract:C:\Updates" -Wait

Write-Host "$(Get-Date -Format G): Installing $update"
Start-Process -FilePath "dism.exe" -ArgumentList "/online /add-package /PackagePath:C:\Updates\$kbid.cab /quiet /norestart /LogPath:C:\Windows\Temp\$kbid.log" -Wait

New-Item 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2'
New-Item 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client'
New-Item 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server'
New-ItemProperty -path 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name Enabled -value 1 -PropertyType 'DWord' -Force
New-ItemProperty -path 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client' -name DisabledByDefault -value 0 -PropertyType 'DWord' -Force
New-ItemProperty -path 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name Enabled -value 1 -PropertyType 'DWord' -Force
New-ItemProperty -path 'HKLM:SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server' -name DisabledByDefault -value 0 -PropertyType 'DWord' -Force

New-ItemProperty -path 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp' -name DefaultSecureProtocols -value 2048 -PropertyType 'DWord' -Force
New-ItemProperty -path 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp' -name DefaultSecureProtocols -value 2048 -PropertyType 'DWord' -Force
New-ItemProperty -path 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings' -name SecureProtocols -value 2048 -PropertyType 'DWord' -Force

Remove-Item -LiteralPath "C:\Updates" -Force -Recurse

Write-Host "$(Get-Date -Format G): Finished installing Windows Management Framework 5.1. The VM will now reboot and continue the installation process."