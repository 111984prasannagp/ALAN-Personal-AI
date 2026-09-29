$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$vendor = Join-Path $root "vendor\mark_lv"

if (-not (Test-Path (Join-Path $vendor "main.py"))) {
    throw "Mark-LV foundation not found. Run scripts\sync_mark_lv.ps1 first."
}

$files = Get-ChildItem $vendor -Recurse -File | Where-Object {
    $_.Extension -in ".py", ".html", ".md", ".txt"
}

$count = 0
foreach ($file in $files) {
    $text = Get-Content $file.FullName -Raw -Encoding UTF8
    if ($null -eq $text -or $text.Length -eq 0) {
        continue
    }

    $new = $text.Replace("JARVIS", "ALAN").Replace("MARK LV", "ALAN")

    if ($new -ne $text) {
        Set-Content $file.FullName -Value $new -Encoding UTF8 -NoNewline
        $count++
    }
}

Write-Host "ALAN branding applied. Files changed: $count"
