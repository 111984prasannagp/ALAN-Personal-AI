$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$target = Join-Path $root "vendor\mark_lv\actions\dev_agent.py"

if (-not (Test-Path $target)) { throw "DevAgent file not found: $target" }

$t = [System.IO.File]::ReadAllText($target)

$t = $t.Replace(
'    if "timed out" in low:
        return False',
'    if "timed out" in low:
        return True'
)

$t = $t.Replace(
'    return error_type != "none"',
'    return error_type != "none"'
)

$t = $t.Replace(
'    if "syntaxerror" in low or "invalid syntax" in low:',
'    if "timed out" in low:
        return "timeout"

    if "syntaxerror" in low or "invalid syntax" in low:'
)

$t = $t.Replace(
'        if error_type == "dependency_error" and auto_installs < 3:',
'        if error_type == "timeout":
            log("The program did not exit within the test window. Checking it with Python compilation before deciding whether it is a real interactive/long-running program.")
            try:
                compile_result = subprocess.run(
                    [sys.executable, "-m", "py_compile", entry_point],
                    capture_output=True, text=True,
                    encoding="utf-8", errors="replace",
                    timeout=20, cwd=str(project_dir)
                )
                if compile_result.returncode == 0:
                    log("Syntax check passed. Repairing the entry point so the requested test can complete without hanging.")
                else:
                    last_output = (compile_result.stderr or compile_result.stdout or "Compilation failed").strip()
                    log("Syntax check failed; sending the actual error to the repair step.")
            except Exception as e:
                log(f"Syntax check failed: {e}")

        if error_type == "dependency_error" and auto_installs < 3:'
)

[System.IO.File]::WriteAllText($target, $t)
Write-Host "DevAgent timeout/success detection patch applied successfully."
