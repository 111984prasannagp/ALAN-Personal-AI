$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$vendor = Join-Path $root "vendor"
$target = Join-Path $vendor "mark_lv"
$temp = Join-Path $env:TEMP "alan-mark-lv.zip"
$tempDir = Join-Path $env:TEMP "alan-mark-lv-src"

Write-Host "Downloading Mark-LV foundation..."
if (Test-Path $temp) { Remove-Item $temp -Force }
if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force }

New-Item -ItemType Directory -Force -Path $vendor | Out-Null
Invoke-WebRequest -Uri "https://github.com/FatihMakes/Mark-LV/archive/refs/heads/main.zip" -OutFile $temp

Write-Host "Extracting..."
Expand-Archive -Path $temp -DestinationPath $tempDir -Force
$extracted = Get-ChildItem $tempDir -Directory | Select-Object -First 1

if (Test-Path $target) { Remove-Item $target -Recurse -Force }
Move-Item $extracted.FullName $target

Remove-Item $temp -Force
Remove-Item $tempDir -Recurse -Force

Write-Host ""
Write-Host "Mark-LV foundation installed at:"
Write-Host $target
Write-Host ""
Write-Host "Next: install its dependencies with:"
Write-Host "pip install -r vendor\mark_lv\requirements.txt"
