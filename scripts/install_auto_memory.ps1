$ErrorActionPreference = "Stop"

$root = "D:\123\ALAN-Personal-AI-main"
$p = Join-Path $root "vendor\mark_lv\main.py"

if (-not (Test-Path $p)) { throw "Mark-LV main.py not found: $p" }

$t = [IO.File]::ReadAllText($p)

$importOld = "import sys"
$importNew = @"
import sys
# ALAN memory bridge
_ALAN_ROOT = str((Path(__file__).resolve().parents[2]))
if _ALAN_ROOT not in sys.path:
    sys.path.insert(0, _ALAN_ROOT)
from alan.memory.store import MemoryStore
from alan.memory.auto_memory import AutoMemory
"@

if ($t.Contains("from alan.memory.auto_memory import AutoMemory")) {
    Write-Host "ALAN memory bridge already installed."
    exit 0
}

if (-not $t.Contains($importOld)) { throw "Import anchor not found." }
$t = $t.Replace($importOld, $importNew, 1)

$initAnchor = "        self._session_log: list[str] = []"
$initNew = @"
        self._session_log: list[str] = []
        self._alan_memory = AutoMemory(
            MemoryStore(Path(_ALAN_ROOT) / "data" / "memory.json")
        )
"@

if (-not $t.Contains($initAnchor)) { throw "Memory initialization anchor not found." }
$t = $t.Replace($initAnchor, $initNew, 1)

$turnAnchor = '                                self._session_log.append(f"User: {full_in}")'
$turnNew = @"
                                self._session_log.append(f"User: {full_in}")
                                try:
                                    self._alan_memory.process(full_in)
                                except Exception as _memory_error:
                                    print(f"[ALAN Memory] Non-fatal: {_memory_error}")
"@

if (-not $t.Contains($turnAnchor)) { throw "Conversation anchor not found." }
$t = $t.Replace($turnAnchor, $turnNew, 1)

[IO.File]::WriteAllText($p, $t)
Write-Host "ALAN auto-memory bridge installed successfully."
