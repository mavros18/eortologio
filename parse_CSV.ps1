$global:_working_dir = $PSScriptRoot
Push-Location -Path $global:_working_dir

$en_CSV = Get-Content -Path ".\eortologio_en.csv"
$el_CSV = Get-Content -Path ".\eortologio_el.csv"

$en = $en_CSV | ConvertFrom-Csv -Delimiter ';'
$el = $el_CSV | ConvertFrom-Csv -Delimiter ';'

$en_JSON = $en | ConvertTo-Json
$el_JSON = $el | ConvertTo-Json

Set-Content -Path ".\eortologio_en.json" -Value $en_json
Set-Content -Path ".\eortologio_el.json" -Value $el_json
