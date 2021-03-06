# Windows 10 Fresh Configuration

I'm constantly re-installing Windows and it's nice to have my configuration setup automatically so I made a few script that run, add each-other at scheduled tasks, then disable and re-enable themselves as my PC performs required restarts while setting programs that I'm always using!

## Steps 

1. Run this in Powershell as Admin:
```
Set-ExecutionPolicy -ExecutionPolicy Bypass -Force ; iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')) ; iex (new-object net.webclient).downloadstring('https://get.scoop.sh');exit
```

2. Start a new Powershell instance and run as admin:
```
set-executionpolicy remotesigned -s currentuser; [System.net.ServicePointManager]::SecurityProtocol = 3072 -bor 768 -bor 192 -bor 48; iwr http://github.com/Francommit/win10_config/raw/master/all_in_one.ps1 -UseBasicParsing | iex
```

### Useful commands on new PC's
Generate a SSH key identity
`ssh-keygen`

WSL Debian 10 Configuration
`sudo apt -y install git zsh curl`

Setup OhMyZsh
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
