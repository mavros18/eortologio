$g_working_dir = $PSScriptRoot
Push-Location -Path $g_working_dir

function loadJSON {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string]$JsonFile
    )

    $e_OBJ = Get-Content -Path $JsonFile | ConvertFrom-Json
    
    return $e_OBJ
}

function getSimera {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][int16]$day,
        [Parameter(Mandatory)][int16]$month
    )


    $e1 = loadJSON -JsonFile ".\merged.json"
    $simera = $e1 | Where-Object { $_.Day -like $_d -and $_.Month -like $_m } | Select-Object Day, Month, Name_en, Name_el, Alt_en, Alt_el
    
    return $simera
}

[int16]$_d = get-date -Format "dd"
[int16]$_m = get-date -Format "MM"

do {
    Write-Host "Day: $_d Month: $_m "

    (getSimera -day $_d -month $_m) | Format-Table

    $input = read-host -Prompt "Date (dd/MM)"
    [int16]$_d = $input.Split("/")[0]
    [int16]$_m = $input.Split("/")[1]

} until ($input -like "0/0")
