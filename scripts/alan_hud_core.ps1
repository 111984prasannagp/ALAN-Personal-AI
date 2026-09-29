$ErrorActionPreference = "Stop"

$ui = Join-Path (Split-Path -Parent $PSScriptRoot) "vendor\mark_lv\ui.py"
if (-not (Test-Path $ui)) { throw "vendor\mark_lv\ui.py not found." }

$t = [System.IO.File]::ReadAllText($ui)

$old = '            self.hud_style = get_hud_style()'
$new = '            self.hud_style = "core"'

if ($t.Contains($old)) {
    $t = $t.Replace($old, $new)
}

$t = $t.Replace('JARVIS''s own voice', 'ALAN''s own voice')
$t = $t.Replace('JARVIS starts talking', 'ALAN starts talking')
$t = $t.Replace('Select a file for JARVIS', 'Select a file for ALAN')

[System.IO.File]::WriteAllText($ui, $t)
Write-Host "ALAN HUD centrepiece switched to the futuristic reactor core."
