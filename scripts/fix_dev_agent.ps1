$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$target = Join-Path $root "vendor\mark_lv\actions\dev_agent.py"

if (-not (Test-Path $target)) { throw "DevAgent file not found: $target" }

$t = [System.IO.File]::ReadAllText($target)

# Classify ImportError before the broad dependency bucket.
$t = $t.Replace(
'    if any(x in low for x in ("no module named", "modulenotfounderror", "importerror")):',
'    if "cannot import name" in low or "cannot import" in low:
        return "import_error"

    if any(x in low for x in ("no module named", "modulenotfounderror")):'
)

$t = $t.Replace(
'    if "cannot import" in low or "importerror" in low:
        return "import_error"
',
''
)

# Keep a signature of the previous failure so repeated identical failures are visible.
$t = $t.Replace(
'    auto_installs = 0  ',
'    auto_installs = 0
    previous_error_signature = None'
)

$t = $t.Replace(
'        error_type = _classify_error(last_output)
        if error_type == "dependency_error"',
'        error_type = _classify_error(last_output)
        error_signature = re.sub(r"\s+", " ", last_output[-1200:]).strip()
        if error_signature == previous_error_signature:
            log("Same error returned after the previous repair; forcing a fresh diagnosis.")
        previous_error_signature = error_signature
        log(f"Diagnosed error: {error_type}")
        if error_type == "dependency_error"'
)

[System.IO.File]::WriteAllText($target, $t)
Write-Host "DevAgent reliability patch applied successfully."
