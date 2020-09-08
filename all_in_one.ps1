# Set the local timezone, I don't know why it's always incorrectly set
Invoke-Expression 'tzutil /s "AUS Eastern Standard Time"'

# Power management
powercfg /h off
powercfg -change -hibernate-timeout-dc 0
powercfg -change -hibernate-timeout-ac 0
powercfg -change -standby-timeout-dc 0
powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -monitor-timeout-ac 30
powercfg -change -disk-timeout-dc 180
powercfg -change -disk-timeout-ac 180

# Setting Windows Explorer settings: Show Hidden Files, Show File Extension, Open Explorer default to This PC
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 0
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key LaunchTo 1
Set-ItemProperty $key ShowTaskViewButton 0

# Hide Search button / box
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
 
# Show all tray icons
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0

# Remove "People Icon" from the taskbar
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /V PeopleBand /T REG_DWORD /D 0 /F

# Turn Off App Suggestions on Start Menu
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338388Enabled /t REG_DWORD /d 0 /f >nul 2>&1

# Disable Stick keys
Write-Output "Disabling Sticky keys prompt..."
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Type String -Value "506"

# Task manager extended details by default
Write-Output "Showing file operations details..."
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager")) {
	New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" -Name "EnthusiastMode" -Type DWord -Value 1
}

# Prevents "Suggested Applications" returning
force-mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content"
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" "DisableWindowsConsumerFeatures" 1

# Enable Windows Containers
Enable-WindowsOptionalFeature -Online -FeatureName containers –All

# Enable Windows Sandbox
Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online

# Install Fundamentals
choco install chocolateygui -y
choco install jdk8 autohotkey -y 
choco install 7zip -y 
choco install microsoft-edge firefox -y 
choco install everything --params "/service" -y
choco install deluge -y
choco install openssh royalts-v5 mobaxterm -y
choco install powershell-core -y
choco install microsoft-windows-terminal -y
choco install docker-desktop -y
choco install discord notion -y

# Install Source Management apps
choco install git kdiff3 gitextensions -y

# Install IDE
choco install vscode vscodium sublimetext3 -y
choco install sublimemerge -y
choco install steam epicgameslauncher -y

# Autohotkey script, capslock to Windows, ctrl + alt + v for pasting in remote sessions
Write-Host "Place default AHK script in Startup folder. Shell:startup to navigate there"

New-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\scripts.ahk" -type file -value "^!v::
SendRaw, %Clipboard%
return
"
# Removing the Default Windows 10 Apps 
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\force-mkdir.psm1

# Taken from - https://gist.github.com/tkrotoff/830231489af5c5818b15
Get-AppxPackage Microsoft.Windows.ParentalControls | Remove-AppxPackage
Get-AppxPackage Windows.ContactSupport | Remove-AppxPackage
Get-AppxPackage Microsoft.Xbox* | Remove-AppxPackage
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage # Mail and Calendar
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
Get-AppxPackage Microsoft.Zune* | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage # Phone Companion
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage
Get-AppxPackage Microsoft.Appconnector | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsFeedback* | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.FeatureOnDemand.InsiderHub | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.Cortana | Remove-AppxPackage
Get-AppxPackage Microsoft.People | Remove-AppxPackage
Get-AppxPackage Microsoft.Bing* | Remove-AppxPackage # Money, Sports, News, Finance and Weather
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage
Get-AppxPackage Microsoft.Advertising.Xaml | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.ParentalControls | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.ContentDeliveryManager | Remove-AppxPackage
Get-AppxPackage *Twitter* | Remove-AppxPackage
Get-AppxPackage king.com.CandyCrushSodaSaga | Remove-AppxPackage
Get-AppxPackage flaregamesGmbH.RoyalRevolt2 | Remove-AppxPackage
Get-AppxPackage *Netflix | Remove-AppxPackage
Get-AppxPackage Facebook.Facebook | Remove-AppxPackage
Get-AppxPackage Microsoft.MinecraftUWP | Remove-AppxPackage
Get-AppxPackage *MarchofEmpires | Remove-AppxPackage


