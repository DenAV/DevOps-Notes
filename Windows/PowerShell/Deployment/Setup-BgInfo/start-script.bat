@Echo off
Set bat_path=%~dp0
Set file_name=setup-bginfo.ps1

powershell.exe -ExecutionPolicy ByPass -File "%bat_path%%file_name%"
timeout /T 10
pause