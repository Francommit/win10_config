# TO-DO: Add default 'everything' shortcut of win+alt+spacebar
# TO-DO: Add ahk scripts to Windows10 'startup' folder. Changed with the creators update.

function Pin-App { param(
[string]$appname,
[switch]$unpin
)
try{
if ($unpin.IsPresent){
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'From "Start" UnPin|Unpin from Start'} | %{$_.DoIt()}
return "App '$appname' unpinned from Start"
}else{
((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ?{$_.Name -eq $appname}).Verbs() | ?{$_.Name.replace('&','') -match 'To "Start" Pin|Pin to Start'} | %{$_.DoIt()}
return "App '$appname' pinned to Start"
}
}catch{
Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
}
}

Write-Host "Configuring start menu"

Pin-App "xbox" -unpin
Pin-App "Microsoft Edge" -unpin
Pin-App "Photos" -unpin
Pin-App "Store" -unpin
Pin-App "Paint 3D" -unpin
Pin-App "Onenote" -unpin

# Row 1
Pin-App "Google Chrome" 
Pin-App "Control Panel"
Pin-App "This PC"

# Row 2
Pin-App "Store"
Pin-App "Onenote" 
Pin-App "Steam" 

# Row 3
Pin-App "Visual Studio Code"
Pin-App "Sublime Text 3" 
Pin-App "Git Extensions" 

# Row 4
Pin-App "Deluge" 
Pin-App "Teamviewer 12" 
Pin-App "Reddit Wallpaper Changer" 
