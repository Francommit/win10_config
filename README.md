# Windows 10 Fresh Configuration

I'm constantly re-installing Windows and it's nice to have my configuration setup automatically so I made a few script that run, add each-other at scheduled tasks, then disable and re-enable themselves as my PC performs required restarts while setting programs that I'm always using!


## Steps

1. Run this in Powershell as Admin:

```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://github.com/Francommit/win10_config/raw/master/1_configure_then_execute.ps1')"
```

2. Enjoy a coffee and return in about half an hour (this varies depending on internet speed).
