$ErrorActionPreference = "Stop"

$root = "D:\123\ALAN-Personal-AI-main"
$p = Join-Path $root "vendor\mark_lv\main.py"

function Replace-Once([string]$text, [string]$old, [string]$new) {
    $i = $text.IndexOf($old, [StringComparison]::Ordinal)
    if ($i -lt 0) { throw "Anchor not found: $old" }
    return $text.Substring(0, $i) + $new + $text.Substring($i + $old.Length)
}

if (-not (Test-Path $p)) { throw "Mark-LV main.py not found: $p" }

$t = [IO.File]::ReadAllText($p)

if ($t.Contains("from alan.memory.auto_memory import AutoMemory")) {
    Write-Host "ALAN memory bridge already installed."
    exit 0
}

$t = Replace-Once $t "import sys" @"
import sys
from pathlib import Path
# ALAN memory bridge
_ALAN_ROOT = str(Path(__file__).resolve().parents[2])
if _ALAN_ROOT not in sys.path:
    sys.path.insert(0, _ALAN_ROOT)
from alan.memory.store import MemoryStore
from alan.memory.auto_memory import AutoMemory
"@

$t = Replace-Once $t "        self._session_log: list[str] = []" @"
        self._session_log: list[str] = []
        self._alan_memory = AutoMemory(
            MemoryStore(Path(_ALAN_ROOT) / "data" / "memory.json")
        )
"@

$t = Replace-Once $t '                                self._session_log.append(f"User: {full_in}")' @"
                                self._session_log.append(f"User: {full_in}")
                                try:
                                    self._alan_memory.process(full_in)
                                except Exception as _memory_error:
                                    print(f"[ALAN Memory] Non-fatal: {_memory_error}")
"@

[IO.File]::WriteAllText($p, $t)
Write-Host "ALAN auto-memory bridge installed successfully."
