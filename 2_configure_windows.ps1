Write-Host "Setting the local timezone."
Invoke-Expression 'tzutil /s "AUS Eastern Standard Time"'

Write-Host "Disabling Microsoft Telemetry Collection"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name AllowTelemetry -Type DWord -Value 0

Write-Host "Setting Power Settings: Disable Hibernation, Disable Standby, Set Various Timeouts"
powercfg /h off
powercfg -change -hibernate-timeout-dc 0
powercfg -change -hibernate-timeout-ac 0
powercfg -change -standby-timeout-dc 0
powercfg -change -standby-timeout-ac 0
powercfg -change -monitor-timeout-dc 0
powercfg -change -monitor-timeout-ac 30
powercfg -change -disk-timeout-dc 180
powercfg -change -disk-timeout-ac 180

Write-Host "Setting Windows Explorer settings: Show Hidden Files, Show File Extension, Open Explorer default to This PC"
Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name AutoRestartShell -Value 0
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key LaunchTo 1
Set-ItemProperty $key ShowTaskViewButton 0

# Show "This PC" on desktop
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0

# Hide Search button / box
Write-Host "Hiding Search Box / Button..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0
 
# Show all tray icons
Write-Host "Showing all tray icons..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0

Write-Host "Starting new script and stopping current one."
Disable-ScheduledTask -TaskName "2_configure_windows"
Enable-ScheduledTask -TaskName "3_main_install"

Write-Host "Restarting..."
Restart-Computer
