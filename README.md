# Windows 10 Fresh Configuration

I'm constantly re-installing Windows and it's nice to have my configuration setup automatically so I made a few script that run, add each-other at scheduled tasks, then disable and re-enable themselves as my PC performs required restarts while setting programs that I'm always using!


## Steps

1. Run this in Powershell as Admin:

```
set-executionpolicy remotesigned -s currentuser; [System.net.ServicePointManager]::SecurityProtocol = 3072 -bor 768 -bor 192 -bor 48; iwr http://github.com/Francommit/win10_config/raw/master/1_configure_then_execute.ps1 -UseBasicParsing | iex
```

2. Enjoy a coffee and return in about half an hour (this varies depending on internet speed).

