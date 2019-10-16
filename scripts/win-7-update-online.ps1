Write-Host "$(Get-Date -Format G): Importing the Boxstarter.WinConfig module"
Import-Module Boxstarter.WinConfig

Write-Host "$(Get-Date -Format G): Running Install-WindowsUpdate"
Install-WindowsUpdate -AcceptEula -SuppressReboots

Write-Host "$(Get-Date -Format G): Completed Install-WindowsUpdate"