# Install Fundamentals
choco install jre8 -y 
choco install 7zip -y 
choco install googleChrome -y 
choco install reddit-wallpaper-changer -y
choco install everything --params "/service" -y
choco install winaero-tweaker  -y

# Install Programming Languages
choco install python -y
choco install nodejs.install -y
choco install autohotkey -y

# Install Source Management apps
choco install git -y
choco install kdiff3 -y
choco install gitextensions -y

# Install Terminals
choco install cmder -y
choco install babun -y

# Install IDEs
choco install sublimetext3 -y

# Install Network tools
choco install deluge -y
choco install teamviewer -y

Write-Host "Starting new script and stopping current one."
Disable-ScheduledTask -TaskName "3_main_install"
Enable-ScheduledTask -TaskName "4_post_install"

Write-Host "Restarting..."
Restart-Computer
