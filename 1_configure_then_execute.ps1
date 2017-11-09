Set-ExecutionPolicy -ExecutionPolicy Bypass -Force

# Install Chocolatey 
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Set up Scheduled Tasks   
$taskNames = @("2_configure_windows","3_main_install","4_post_install")

$msg = "Enter the username and password that will run the Powershell Scripts"
$credential = $Host.ui.PromptForCredential("",$msg,"$env:userdomain\$env:username","")
$username = $credential.UserName
$password = $credential.GetNetworkCredential().Password

foreach ($taskName in $taskNames) {

    $url = "https://github.com/Francommit/win10_config/raw/master/$taskName.ps1"
    $file = "$taskName.ps1"
    $output = "C:\" + $file
    
    Write-Host $url
    Write-Host $file
    Write-Host $output
    
    Invoke-WebRequest $url -Out $output
    
    $argument =  "c:\$taskName.ps1"
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $argument
    $trigger = New-ScheduledTaskTrigger -AtLogon
    $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -DontStopOnIdleEnd  

    $principal = New-ScheduledTaskPrincipal -UserID $username -LogonType ServiceAccount -RunLevel Highest
    $description = "This task will run the script $taskName.ps1"

    $Task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Description $description

    # Still possible in Windows10 to have an Admin account without a password
    if ($password) { 
        $Task | Register-ScheduledTask -TaskName "$taskName" -User $UserName -Password $password  
    } else { 
        $Task | Register-ScheduledTask -TaskName "$taskName" -User $UserName
    }
   
}

Disable-ScheduledTask -TaskName "3_main_install"
Disable-ScheduledTask -TaskName "4_post_install"

Write-Host "Restarting..."
Restart-Computer
