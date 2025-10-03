<#
# create C:\Scripts\BgInfo 
# check C:\Scripts\BgInfo\Bginfo64.exe if not found copy
# check C:\Scripts\BgInfo\server.bgi if not found copy
# copy from .\Bginfo-Autostart.bgi.lnk to C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup\Bginfo-Autostart.bgi.lnk
$PSScriptRoot
#>

<#
Here is a sample script algorithm:
    - 
    - End the script
#>

## variables
$targetFolder = "C:\Scripts\BgInfo"

# Determine the folder in which the script is located
$scriptPath = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
$scriptName = [System.IO.Path]::GetFileNameWithoutExtension($myInvocation.MyCommand.Definition)

$StartMenuPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"

Push-Location $scriptPath

# Log file full path
$Date = [datetime]::Now.ToString("yyyyMMdd-HHmm-ss")
$logfile = "{0}\{1}_{2}.log" -f $PSScriptRoot, $scriptName, $Date

Write-Host "Logging to $logfile ..." -ForegroundColor Cyan

####################################
#### Start - Area for functions ####
# <# Here you write the code for functions #>
function set-bginfo {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path -Path $_ })]
        [String]$Destination
    )
    
    begin {
        $checkExe = Test-Path -Path "$($Destination)\Bginfo64.exe" -PathType leaf -ErrorAction Continue
        $checkBgi = Test-Path -Path "$($Destination)\server.bgi" -PathType leaf -ErrorAction Continue
        $checkLnk = Test-Path -Path "$($StartMenuPath)\Bginfo-Autostart.bgi.lnk" -PathType leaf -ErrorAction Continue
    }
    
    process {
        # if not Bginfo64.exe copy to a path
        $i = "Bginfo64.exe"
        if ($checkExe) {
            Write-Output "The file $($Destination)\$($i) already exist."
        } else {
            Write-Output "The file $($i) copy to $($Destination)."

            $sour = "{0}\src\{1}" -f $scriptPath, $i
            $dest = "{0}\{1}" -f $Destination, $i
            Copy-Item -Path $sour -Destination $dest -Force -ErrorAction Continue
        }

        # if not server.bgi copy to a path
        $i = "server.bgi"
        if ($checkBgi) {
            Write-Output "The file $($Destination)\$($i) already exist."
        } else {
            Write-Output "The file $($i) copy to $($Destination)."

            $sour = "{0}\src\{1}" -f $scriptPath, $i
            $dest = "{0}\{1}" -f $Destination, $i
            Copy-Item -Path $sour -Destination $dest -Force -ErrorAction Continue
        }

        # if not Bginfo-Autostart.bgi.lnk copy to a path
        $i = "Bginfo-Autostart.bgi.lnk"
        if ($checkLnk) {
            Write-Output "The file $($StartMenuPath)\$($i) already exist."
        } else {
            Write-Output "The file $($i) copy to $($StartMenuPath)."

            $sour = "{0}\src\{1}" -f $scriptPath, $i
            $dest = "{0}\{1}" -f $StartMenuPath, $i
            Copy-Item -Path $sour -Destination $dest -Force -ErrorAction Continue
        }
    }

}

##### END - Area for functions #####
####################################

#####################################################
#################### Start Script ###################
Start-Transcript $LogFile

# check folder
if (-not (Test-Path $targetFolder)) {

    Write-Output "Create target folder: $targetFolder"

    try {
        New-Item -Path $targetFolder -ItemType Directory -Force | Out-Null
    
        set-bginfo -Destination $targetFolder
    }
    catch {
        Write-Error $_.Exception.Message
    }

} else {
    try {
        set-bginfo -Destination $targetFolder
    }
    catch {
        Write-Error $_.Exception.Message
    }
}

Stop-Transcript
#################### END Script #######################
#######################################################
