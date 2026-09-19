$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$jsonFiles = Get-ChildItem -Path $root -Recurse -File -Filter '*.json' |
    Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' }

foreach ($file in $jsonFiles) {
    $null = Get-Content -LiteralPath $file.FullName -Raw | ConvertFrom-Json
    Write-Host "[OK] $($file.FullName.Substring($root.Length + 1))"
}

$required = @(
    'openapi\mytodo-api.json',
    'schemas\todo.schema.json',
    'schemas\todo-sync-payload.schema.json',
    'schemas\sync.schema.json',
    'config\reminder-profiles.json',
    'fixtures\reminder-cases.json',
    'fixtures\sync-cases.json'
)

foreach ($relativePath in $required) {
    if (-not (Test-Path -LiteralPath (Join-Path $root $relativePath))) {
        throw "缺少协议文件：$relativePath"
    }
}

Write-Host "Contracts 检查完成，共验证 $($jsonFiles.Count) 个 JSON 文件。"
