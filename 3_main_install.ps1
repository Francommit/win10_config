# Install Fundamentals
choco install jdk8 -y 
choco install 7zip -y 
choco install googlechrome -y 
choco install everything --params "/service" -y
choco install deluge -y
choco install autohotkey -y
choco install royalts-v5 -y
choco install openssh -y
choco install powershell-core -y

# Install Source Management apps
choco install git -y
choco install kdiff3 -y
choco install gitextensions -y

# Install IDE
choco install sublimetext3 -y
choco install sublimetext3.powershellalias -y

Write-Host "Starting new script and stopping current one."
Disable-ScheduledTask -TaskName "3_main_install"
Enable-ScheduledTask -TaskName "4_post_install"

Write-Host "Restarting..."
Restart-Computer
