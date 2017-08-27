Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

# Install Chocolatey 
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
