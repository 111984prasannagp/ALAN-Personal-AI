$ErrorActionPreference = "Stop"

$ui = Join-Path (Split-Path -Parent $PSScriptRoot) "vendor\mark_lv\ui.py"
if (-not (Test-Path $ui)) { throw "vendor\mark_lv\ui.py not found." }

$t = [System.IO.File]::ReadAllText($ui)

$replacements = @{
    '#00060a' = '#070711'
    '#010d14' = '#0d0d18'
    '#010f18' = '#11111f'
    '#0d3347' = '#25253a'
    '#1a5c7a' = '#3b3566'
    '#0f4060' = '#493b78'
    '#00d4ff' = '#8b5cf6'
    '#007a99' = '#6d4ed8'
    '#001f2e' = '#17102b'
    '#ff6b00' = '#ff5c8a'
    '#ffcc00' = '#ffd166'
    '#00ff88' = '#58e6b1'
    '#00aa55' = '#2ca879'
    '#ff3355' = '#ff5470'
    '#ff3366' = '#ff6b9a'
    '#8ffcff' = '#e9e7ff'
    '#3a8a9a' = '#77738f'
    '#5ab8cc' = '#aaa5c7'
    '#d8f8ff' = '#f5f3ff'
    '#000d14' = '#0a0a12'
    '#011520' = '#151523'
}

foreach ($old in $replacements.Keys) {
    $t = $t.Replace($old, $replacements[$old])
}

$t = $t.Replace('Courier New', 'Segoe UI')
$t = $t.Replace('border-radius: 3px', 'border-radius: 12px')
$t = $t.Replace('border-radius: 6px', 'border-radius: 14px')

[System.IO.File]::WriteAllText($ui, $t)
Write-Host "ALAN modern skin applied successfully."
