# win10_config

I'm basically sick and tired of having multiple 'windows batch installers' to get a fresh Windows 10 machine set-up to my liking or having to configure it to a particular state in a 'good enough' state for friends and family.

The aim of this repository is just to provide a quick set of commonly used tools that configure up multiple different desktop machines.


## Steps

Run this in Powershell:

```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://github.com/Francommit/win10_config/raw/master/1_configure_then_execute.ps1')"
```


Old Steps:
1. Download all files as a zip and extract
3. Set "Set-ExecutionPolicy -ExecutionPolicy Bypass -Force" in Powershell as Admin & install chocolatey
2. Run through each scripts (2,3 then 4) in Powershell as an Administrator, after your PC restarts run the next script.
3. After running script four the process is complete. Windows 10 should be configured and ready to go.

## TO-DO

1. Test the scheduled task idea
2. Log to a file somewhere
