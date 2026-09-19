param(
    [string]$ServerUrl = 'http://127.0.0.1:3100'
)

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$destination = Join-Path $root 'openapi\mytodo-api.json'
$spec = Invoke-RestMethod "$($ServerUrl.TrimEnd('/'))/docs-json" -TimeoutSec 10
$json = $spec | ConvertTo-Json -Depth 100
[System.IO.File]::WriteAllText($destination, $json, [System.Text.UTF8Encoding]::new($false))
Write-Host "已更新 $destination"
