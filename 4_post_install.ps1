
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

Write-Output "Uninstalling default apps"
$apps = @(
    # default Windows 10 apps
    "Microsoft.3DBuilder"
    "Microsoft.Appconnector"
    "Microsoft.BingFinance"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingWeather"
    "Microsoft.FreshPaint"
    "Microsoft.Getstarted"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.SkypeApp"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCamera"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsPhone"
    "Microsoft.WindowsSoundRecorder"
    "microsoft.windowscommunicationsapps"
    "Microsoft.MinecraftUWP"
    "Microsoft.MicrosoftPowerBIForWindows"
    "Microsoft.NetworkSpeedTest"
    
    # Threshold 2 apps
    "Microsoft.CommsPhone"
    "Microsoft.ConnectivityStore"
    "Microsoft.Messaging"
    "Microsoft.Office.Sway"
    "Microsoft.OneConnect"
    "Microsoft.WindowsFeedbackHub"


    #Redstone apps
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingTravel"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.WindowsReadingList"

    # non-Microsoft
    "9E2F88E3.Twitter"
    "PandoraMediaInc.29680B314EFC2"
    "Flipboard.Flipboard"
    "ShazamEntertainmentLtd.Shazam"
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"
    "king.com.*"
    "ClearChannelRadioDigital.iHeartRadio"
    "4DF9E0F8.Netflix"
    "6Wunderkinder.Wunderlist"
    "Drawboard.DrawboardPDF"
    "2FE3CB00.PicsArt-PhotoStudio"
    "D52A8D61.FarmVille2CountryEscape"
    "TuneIn.TuneInRadio"
    "GAMELOFTSA.Asphalt8Airborne"
    "TheNewYorkTimes.NYTCrossword"
    "DB6EA5DB.CyberLinkMediaSuiteEssentials"
    "Facebook.Facebook"
    "flaregamesGmbH.RoyalRevolt2"
    "Playtika.CaesarsSlotsFreeCasino"
    "A278AB0D.MarchofEmpires"
    "KeeperSecurityInc.Keeper"
    "ThumbmunkeysLtd.PhototasticCollage"
    "XINGAG.XING"
    "89006A2E.AutodeskSketchBook"
    "D5EA27B7.Duolingo-LearnLanguagesforFree"
    "46928bounde.EclipseManager"
    "ActiproSoftwareLLC.562882FEEB491"
    "DolbyLaboratories.DolbyAccess"
    "SpotifyAB.SpotifyMusic"
    "A278AB0D.DisneyMagicKingdoms"
    "WinZipComputing.WinZipUniversal"
)

foreach ($app in $apps) {
    Write-Output "Trying to remove $app"

    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers

    Get-AppXProvisionedPackage -Online |
        Where-Object DisplayName -EQ $app |
        Remove-AppxProvisionedPackage -Online
}


# Prevents "Suggested Applications" returning
force-mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content"
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" "DisableWindowsConsumerFeatures" 1


Write-Host "Removing old scheduled tasks"
Unregister-ScheduledTask -TaskName "2_configure_windows" -Confirm:$false
Unregister-ScheduledTask -TaskName "3_main_install" -Confirm:$false
Unregister-ScheduledTask -TaskName "4_post_install" -Confirm:$false

Write-Host "Restarting..."
Restart-Computer