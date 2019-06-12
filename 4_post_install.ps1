
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

# Autohotkey script, no capslock, sticku windows, ctral + alt + v for pasting in remote sessions
Write-Host "Place default AHK script in Startup folder. Shell:startup to navigate there"

New-Item "$env:appdata\Microsoft\Windows\Start Menu\Programs\Startup\auto_closers.ahk" -type file -value "^!v::
SendRaw, %Clipboard%
return

^SPACE::  Winset, Alwaysontop, , A

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

# Prevents "Suggested Applications" returning
force-mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content"
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" "DisableWindowsConsumerFeatures" 1


Write-Host "Removing old scheduled tasks"
Unregister-ScheduledTask -TaskName "2_configure_windows" -Confirm:$false
Unregister-ScheduledTask -TaskName "3_main_install" -Confirm:$false
Unregister-ScheduledTask -TaskName "4_post_install" -Confirm:$false

Write-Host "Restarting..."
Restart-Computer
