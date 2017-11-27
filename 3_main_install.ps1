
# Install Fundamentals
choco install vcredist2015 -y 
choco install directx -y
choco install jre8 -y 
choco install 7zip -y 
choco install googleChrome -y 
choco install flashplayerplugin -y 
choco install libreoffice -y
choco install reddit-wallpaper-changer -y

# Install gaming tools
choco install gamesavemanager -y
choco install cheatengine -y

# Install Common Languages
choco install python -y
choco install nodejs.install -y
choco install autohotkey -y

# Install Source Management apps
choco install git -y
choco install kdiff3 -y
choco install everything --params "/service" -y
choco install gitextensions -y
choco install quicklook -y
choco install cmder -y

# Install IDEs
choco install visualstudiocode -y
choco install sublimetext3 -y
choco install visualstudio2017-installer
choco install firacode -y

# Install Communication applications
choco install skype -y
choco install steam -y 

# Install Img tools
choco install imgburn -y 
choco install rufus -y
choco install gimp -y 

# Install Network tools
choco install putty -y
choco install deluge -y
choco install teamviewer -y

Write-Host "Starting new script and stopping current one."
Disable-ScheduledTask -TaskName "3_main_install"
Enable-ScheduledTask -TaskName "4_post_install"

Write-Host "Restarting..."
Restart-Computer
