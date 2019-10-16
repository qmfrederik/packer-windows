Write-Host "$(Get-Date -Format G): Installing the NuGet package provider"
Get-PackageProvider -Name NuGet -Force

Write-Host "$(Get-Date -Format G): Installing windows update powershell module"
Install-Module PSWindowsUpdate -Confirm:$false -Force

Write-Host "$(Get-Date -Format G): Running Get-WindowsUpdate"
Get-WindowsUpdate -Confirm:$false

Write-Host "$(Get-Date -Format G): Running Install-WindowsUpdate"
# Exclude language packs and preview updates
# (e.g. Preview of Monthly Rollup)
Install-WindowsUpdate -NotCategory "Windows 7 Language Packs" -NotTitle "Preview" -Confirm:$false -AutoReboot:$false -IgnoreReboot

Write-Host "$(Get-Date -Format G): Completed Install-WindowsUpdate."