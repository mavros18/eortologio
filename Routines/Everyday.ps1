##Requires -Version 5.1

trap {
    $err = $_
    Write-Error $err
}

function ballonTip {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)][string]$message,
        [Parameter(Position = 1)][string]$title,
        [Parameter(Position = 2)][ValidateSet("None", "Info", "Warning", "Error")][string]$icon = "None",
        [Parameter(Position = 3)][int32]$timeout = 5000

    )
    
    Add-Type -AssemblyName System.Windows.Forms 
    $global:balloon = New-Object System.Windows.Forms.NotifyIcon
    $path = (Get-Process -id $pid).Path
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
    $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::$icon
    $balloon.BalloonTipText = "$message"
    $balloon.BalloonTipTitle = "$title" 
    $balloon.Visible = $true 
    $balloon.ShowBalloonTip($timeout)
}

function msgbox {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)][string]$message,
        [Parameter()][string]$title
    )

    $wshell = New-Object -ComObject Wscript.Shell
    $wshell.Popup($message)

}
# Start-Sleep 30

# $powershellEXE = Join-Path $env:windir "system32\WindowsPowerShell\v1.0\powershell.exe"
$ddd = ($(Get-Date)).DayOfWeek
$time = ($(Get-Date)).ToShortTimeString()
$workingHours = $true


# only run on weekdays before 10:30 am
if ( ($ddd -clike "S*") -or ( $time -gt 1600 )) {
    $workingHours = $false
}

if ($workingHours) {
    
    Write-Host "`n---`nStarting...`n"

    Write-Host "Surfshark"
    $i = 3
    do {
        Write-Host "." -NoNewline
        Start-Process "C:\Program Files (x86)\Surfshark\Surfshark.exe"
        Start-Sleep $i
        $vpn = (Get-NetIPConfiguration | Where-Object {$_.NetProfile.Name -like "IKEv2-Surfshark*"}).Count 
        $i += 1
    } while ( ($vpn -lt 1) -and ($i -lt 10) )
	
    Write-Host "`nEdge"
    # Start-Process microsoft-edge:https://app.liquidplanner.com/space/202379/my_work 
    Start-Process microsoft-edge:https://www.news247.gr/ 
    # Start-Process microsoft-edge:https://www.bbc.co.uk/weather/so23 
    Start-Sleep 5   

    # if ($vpn -eq 1) {
        Write-Host "MS Teams"
        C:\Users\mavro\AppData\Local\Microsoft\Teams\Update.exe --processStart "Teams.exe"
        Start-Sleep 5
    
        Write-Host "Outlook"
        Start-Process "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
        Start-Sleep 5
    # }
}

Write-Host "Eortologio"
. '..\eortologio\eortologio.ps1'
$namedays = getNamedays
$namedaySTR = ""
foreach ($item in $($namedays.Name_el)) {
    if (-not ([string]::IsNullOrEmpty($namedaySTR)) ) {
        $namedaySTR += ", "
    }
    $namedaySTR += $item
}

$tlt = "Have a great $ddd!"
$msg = "Namedays:`n$namedaySTR"
ballonTip $msg $tlt "Info" 1000000
#msgbox $msg

exit 0
