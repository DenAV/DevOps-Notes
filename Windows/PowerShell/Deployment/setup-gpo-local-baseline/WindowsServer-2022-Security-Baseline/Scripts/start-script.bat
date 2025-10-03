@Echo off
Set bat_path=%~dp0
Set file_name1=Baseline-LocalInstall.ps1
Set file_name2=Set-SecureProtocols.ps1
Set file_name3=Setup-OtherConfiguration.ps1

powershell.exe -ExecutionPolicy ByPass -File "%bat_path%%file_name1%" -WSNonDomainJoined

sleep 2
powershell.exe -ExecutionPolicy ByPass -File "%bat_path%%file_name2%"

sleep 2
powershell.exe -ExecutionPolicy ByPass -File "%bat_path%%file_name3%"

timeout /T 5
pause