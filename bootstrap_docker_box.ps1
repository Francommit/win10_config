Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install git.install -y
choco install openssh -y
Install-Module DockerMsftProvider -Force
Install-Package Docker -ProviderName DockerMsftProvider -Force
Install-WindowsFeature Containers
Restart-Computer

# ssh-keygen -t rsa -C "whatever"
# Get-Content C:\Users\Administrator\.ssh\id_rsa
