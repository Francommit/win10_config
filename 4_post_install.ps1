
function Pin-App { param(
[string]$appname,
[switch]$unpin
)
    try {
        if ($unpin.IsPresent) {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'From "Start" UnPin|Unpin from Start'} | %{$_.DoIt()}
            return "App '$appname' unpinned from Start"
        } else {
            ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'To "Start" Pin|Pin to Start'} | %{$_.DoIt()}
            return "App '$appname' pinned to Start"
        }
    }
    catch {
        Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
    }
}


# Allowing using 'subl' on the command line
Write-Host "Adding Sublime Text 3 to the system path as 'subl'"
$systemPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name Path).Path
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value ($systemPath += ';C:\Program Files\Sublime Text 3\') 


Write-Host "Configuring start menu"

# Apps to remove
Pin-App "xbox" -unpin
Pin-App "Microsoft Edge" -unpin
Pin-App "Photos" -unpin
Pin-App "Store" -unpin
Pin-App "Paint 3D" -unpin

# Pinned Apps
Pin-App "Google Chrome" 
Pin-App "Control Panel"
Pin-App "This PC"
Pin-App "Store"
Pin-App "Onenote" 
Pin-App "Sublime Text 3" 
Pin-App "Git Extensions" 
Pin-App "Deluge" 
Pin-App "Teamviewer 13" 
Pin-App "Reddit Wallpaper Changer" 


# Autohotkey script auto-start
Write-Host "Place default AHK script in Startup folder. Shell:startup to navigate there"

New-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\auto_closers.ahk" -type file -value "#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
DetectHiddenWindows Off
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


Macro1:
Loop
{
    WinActivate, This is an unregistered copy
    Sleep, 333
    WinKill, This is an unregistered copy
    Sleep, 333
}
Return
"


# Removing the Default Windows 10 Apps 
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\force-mkdir.psm1

# Taken from - https://github.com/Sycnex/Windows10Debloater/blob/master/Individual%20Scripts/Debloat%20Windows
Write-Output "Uninstalling default apps"
$AppXApps = @(

        #Unnecessary Windows 10 AppX Apps
        "*Microsoft.BingNews*"
        "*Microsoft.GetHelp*"
        "*Microsoft.Getstarted*"
        "*Microsoft.Messaging*"
        "*Microsoft.Microsoft3DViewer*"
        "*Microsoft.MicrosoftOfficeHub*"
        "*Microsoft.MicrosoftSolitaireCollection*"
        "*Microsoft.NetworkSpeedTest*"
        "*Microsoft.Office.Sway*"
        "*Microsoft.OneConnect*"
        "*Microsoft.People*"
        "*Microsoft.Print3D*"
        "*Microsoft.SkypeApp*"
        "*Microsoft.WindowsAlarms*"
        "*Microsoft.WindowsCamera*"
        "*microsoft.windowscommunicationsapps*"
        "*Microsoft.WindowsFeedbackHub*"
        "*Microsoft.WindowsMaps*"
        "*Microsoft.WindowsSoundRecorder*"
        "*Microsoft.Xbox.TCUI*"
        "*Microsoft.XboxApp*"
        "*Microsoft.XboxGameOverlay*"
        "*Microsoft.XboxIdentityProvider*"
        "*Microsoft.XboxSpeechToTextOverlay*"
        "*Microsoft.ZuneMusic*"
        "*Microsoft.ZuneVideo*"

        #Sponsored Windows 10 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        "*EclipseManager*"
        "*ActiproSoftwareLLC*"
        "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
        "*Duolingo-LearnLanguagesforFree*"
        "*PandoraMediaInc*"
        "*CandyCrush*"
        "*Wunderlist*"
        "*Flipboard*"
        "*Twitter*"
        "*Facebook*"
        "*Spotify*"
    )
    
foreach ($App in $AppXApps) {
    Write-Verbose -Message ('Removing Package {0}' -f $App)
    Get-AppxPackage -Name $App | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxPackage -Name $App -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $App | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}
    
#Removes AppxPackages
[regex]$WhitelistedApps = 'Microsoft.Paint3D|Microsoft.WindowsCalculator|Microsoft.WindowsStore|Microsoft.Windows.Photos|CanonicalGroupLimited.UbuntuonWindows|Microsoft.XboxGameCallableUI|Microsoft.XboxGamingOverlay|Microsoft.Xbox.TCUI|Microsoft.XboxGamingOverlay|Microsoft.XboxIdentityProvider|Microsoft.MicrosoftStickyNotes|Microsoft.MSPaint*'
Get-AppxPackage -AllUsers | Where-Object {$_.Name -NotMatch $WhitelistedApps} | Remove-AppxPackage
Get-AppxPackage | Where-Object {$_.Name -NotMatch $WhitelistedApps} | Remove-AppxPackage
Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -NotMatch $WhitelistedApps} | Remove-AppxProvisionedPackage -Online

# Prevents "Suggested Applications" returning
force-mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content"
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" "DisableWindowsConsumerFeatures" 1


Write-Host "Removing old scheduled tasks"
Unregister-ScheduledTask -TaskName "2_configure_windows" -Confirm:$false
Unregister-ScheduledTask -TaskName "3_main_install" -Confirm:$false
Unregister-ScheduledTask -TaskName "4_post_install" -Confirm:$false

Write-Host "Restarting..."
Restart-Computer
