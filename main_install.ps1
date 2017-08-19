Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

###############################
# Global Settings
###############################

# Install Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Install default packages
choco install vcredist2015 -y 
choco install googleChrome -y 
choco install 7zip -y 
choco install flashplayerplugin -y 
choco install nodejs.install -y
choco install dotnet4.5 -y 
choco install libreoffice -y
choco install imgburn -y 
choco install sublimetext3 -y
choco install git -y
choco install gitextensions -y
choco install skype -y
choco install everything -y
choco install python -y
choco install steam -y 
choco install jre8 -y 
choco install visualstudiocode -y
choco install autohotkey -y
choco install visualstudio2017-installer
choco install kdiff3 -y
choco install rufus -y
choco install deluge -y
choco install teamviewer -y

#Download Avira Ninite installer
$url = "https://ninite.com/avira/ninite.exe"
$output = "$PSScriptRoot\avira_ninite_installer.exe"
$start_time = Get-Date
Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

# Create Scheduled Task to run Avira installer provided by Ninite
$action = New-ScheduledTaskAction -Execute $output
$trigger =  New-ScheduledTaskTrigger -Once -At 9am
$taskName = "install_avira"
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Description "Start Avira Installer without UAC" -RunLevel Highest
Start-ScheduledTask -TaskName $taskName

# Remove shortcuts after Chocolatey install:
Remove-Item -Path "C:\Users\Public\Desktop\ImgBurn.lnk"
Remove-Item -Path "C:\Users\Public\Desktpo\VLC media player.lnk"

# Install Nvidia driver and Geforce Experience if System has Nvidia GPU
If((Get-WmiObject win32_VideoController | Select Name) -match "nvidia") {
    choco install geforce-experience -y 
    choco install geforce-game-ready-driver -y 
}

# Remove Unused Windows 10 "Apps"
Get-AppxPackage *3dbuilder* | Remove-AppxPackage
Get-AppxPackage *bingsports* | Remove-AppxPackage
Get-AppxPackage *bingfinance* | Remove-AppxPackage
Get-AppxPackage *solitairecollection* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage
Get-AppxPackage *skypeapp* | Remove-AppxPackage
Get-AppxPackage *officehub* | Remove-AppxPackage

# Disable WiFi Hotspot Auto Connect
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name value -Type DWord -Value 0

# Disable WiFi Hotspot Sharing
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name value -Type DWord -Value 0

# Disable Microsoft Telemetry Collection
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name AllowTelemetry -Type DWord -Value 0

# Power Settings: Disable Hibernation, Disable Standby, Set Various Timeouts
powercfg /h off
powercfg -change -hibernate-timeout-dc 0
powercfg -change -hibernate-timeout-ac 0
powercfg -change -standby-timeout-dc 0
powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -monitor-timeout-ac 30
powercfg -change -disk-timeout-dc 180
powercfg -change -disk-timeout-ac 180

# Always show "Command Line here" On right click for folders and background
New-PSDrive -PSProvider registry -Root HKEY_CLASSES_ROOT -Name HKCR
Remove-ItemProperty -Path "HKCR:\Directory\shell\cmd" -Name "Extended"
Remove-ItemProperty -Path "HKCR:\Directory\Background\shell\cmd" -Name "Extended"


################################
# Profile/Current User Settings
################################

# Windows Explorer settings: Show Hidden Files, Always Show Menus, Show File Extension, Open Explorer default to This PC, Confirm Delete to Recycle Bin
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 0
Stop-Process -Force -ProcessName "explorer"
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key AlwaysShowMenus 1
Set-ItemProperty $key LaunchTo 1
Set-ItemProperty $key TaskbarGlomLevel 1
Set-ItemProperty $key ShowTaskViewButton 0

# Disable Taskbar Search Icon
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name SearchboxTaskbarMode -Type DWord -Value 0

# Disable Bing Search
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name BingSearchEnabled -Type DWord -Value 0

# Disable SmartScreen Filter for Store Apps
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" -Name EnableWebContentEvaluation -Type DWord -Value 0

# Make desktop menus faster
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name MenuShowDelay -Value 200

# Show "This PC" on desktop
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0