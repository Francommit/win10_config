# win10_config

I'm basically sick and tired of having multiple 'windows batch installers' to get a fresh Windows 10 machine set-up to my liking or having to configure it to a particular state in a 'good enough' state for friends and family.

The aim of this repository is just to provide a quick set of commonly used tools that configure up multiple different desktop machines.


## Steps

Run this in Powershell as Admin:

```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://github.com/Francommit/win10_config/raw/master/1_configure_then_execute.ps1')"
```

## TO-DO

1. Log to a file somewhere
