$global:_working_dir = $PSScriptRoot
Push-Location -Path $global:_working_dir

$c_JSON = Get-Content -Path ".\eortologio_en.json"
$en = $c_JSON | ConvertFrom-Json

$c_JSON = Get-Content -Path ".\eortologio_el.json"
$el = $c_JSON | ConvertFrom-Json


if ($en.Count -eq $el.Count) {
    $merged = @()
    for ($i = 0; $i -lt $el.Count; $i++) {
        $m = @(
            @{
                "name_en" = $en[$i].name
                "name_el" = $el[$i].name
                "alt_en"  = $en[$i].alt
                "alt_el"  = $el[$i].alt
                "day"     = $en[$i].day
                "month"   = $en[$i].month
            }
        )
        $merged += $m
        
    }
}


$m_JSON = $merged | ConvertTo-Json
Set-Content -Path ".\merged.json" -Value $m_JSON

# $m_CSV = $merged | ConvertTo-Csv -Delimiter ';'
# Set-Content -Path ".\merged.csv" -Value $m_CSV

