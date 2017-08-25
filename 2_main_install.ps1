# TO-DO: Add default 'everything' shortcut of win+alt+spacebar
# TO-DO: Add ahk scripts to Windows10 'startup' folder. Changed with the creators update.
# TO-DO: Add the Reddit Wallpaper changer.
# TO-DO: Make taskbar appear on right side of monitor.



# Update-SessionEnvironment


# Install Fundamentals
choco install vcredist2015 -y 
choco install jre8 -y 
choco install 7zip -y 
choco install googleChrome -y 
choco install flashplayerplugin -y 
choco install libreoffice -y

# Install Common Languages
choco install python -y
choco install nodejs.install -y
choco install autohotkey -y

# Install Source Management apps
choco install git -y
choco install kdiff3 -y
choco install gitextensions -y
choco install everything -y

# Install IDEs
choco install visualstudiocode -y
choco install sublimetext3 -y
choco install visualstudio2017-installer

# Install Communication applications
choco install skype -y
choco install steam -y 

# Install Img tools
choco install imgburn -y 
choco install rufus -y
choco install gimp2 -y 

# Install Network tools
choco install putty -y
choco install deluge -y
choco install teamviewer -y

# Remove Unused Windows 10 Apps
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

# Windows Explorer settings: Show Hidden Files, Always Show Menus, Show File Extension, Open Explorer default to This PC
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 0
Stop-Process -Force -ProcessName "explorer"
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key AlwaysShowMenus 1
Set-ItemProperty $key LaunchTo 1
Set-ItemProperty $key TaskbarGlomLevel 1
Set-ItemProperty $key ShowTaskViewButton 0

# Show "This PC" on desktop
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0
