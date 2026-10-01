
$ErrorActionPreference = "Stop"
$root = "D:\123\ALAN-Personal-AI-main"
$mem = Join-Path $root "alan\memory\auto_memory.py"
$settings = Join-Path $root "vendor\mark_lv\actions\computer_settings.py"
$control = Join-Path $root "vendor\mark_lv\actions\computer_control.py"

if (!(Test-Path $mem)) { throw "Missing: $mem" }
if (!(Test-Path $settings)) { throw "Missing: $settings" }
if (!(Test-Path $control)) { throw "Missing: $control" }

$memoryCode = @'
"""Safe automatic + explicit memory bridge for ALAN."""
from __future__ import annotations
import re
from typing import Optional

try:
    from memory import memory_manager as _legacy
except Exception:
    _legacy = None

class AutoMemory:
    def __init__(self, store=None):
        self.store = store

    def _save(self, fact: str, explicit: bool) -> Optional[str]:
        fact = (fact or "").strip()
        if not fact:
            return None
        if _legacy is not None:
            category = "notes"
            low = fact.lower()
            if any(x in low for x in ("my name", "call me", "my age", "i am ", "i'm ")):
                category = "identity"
            elif any(x in low for x in ("i prefer", "i like", "i love", "favorite", "whenever i say", "when i say")):
                category = "preferences"
            elif any(x in low for x in ("my project", "i am building", "i'm building", "project")):
                category = "projects"
            key = re.sub(r"[^a-z0-9]+", "_", fact.lower()).strip("_")[:70] or "memory"
            try:
                _legacy.remember(key, fact, category=category)
                return f"{category}/{key}"
            except Exception as e:
                print(f"[ALAN Memory] legacy save failed: {e}")
        return None

    def explicit(self, text: str) -> Optional[str]:
        text = (text or "").strip()
        if not re.search(r"\b(?:remember|save|store|keep|memorize)\b", text, re.I):
            return None
        fact = re.sub(r"^.*?\b(?:remember|save|store|keep|memorize)\b\s*", "", text, count=1, flags=re.I).strip(" .:,-")
        return self._save(fact or text, True)

    def automatic(self, text: str) -> Optional[str]:
        text = (text or "").strip()
        if not text or len(text) > 300:
            return None
        if not re.search(r"\b(?:my name is|call me|i prefer|i like|i love|my favorite|whenever i say|when i say|my project is|i study|my laptop|my phone|my game)\b", text, re.I):
            return None
        return self._save(text, False)

    def process(self, text: str) -> Optional[str]:
        return self.explicit(text) or self.automatic(text)
'@
[IO.File]::WriteAllText($mem, $memoryCode)

$settingsText = [IO.File]::ReadAllText($settings)
$start = $settingsText.IndexOf("def close_app():")
$end = $settingsText.IndexOf("def close_window():")
if ($start -lt 0 -or $end -lt 0) { throw "Window action block not found." }

$replacement = @'
def close_app(target: str = ""):
    """Close a requested Windows app without closing ALAN by mistake."""
    target = (target or "").strip()
    if _OS == "Windows":
        if target:
            low = target.lower()
            aliases = {
                "chrome": "chrome", "google chrome": "chrome",
                "edge": "msedge", "microsoft edge": "msedge",
                "firefox": "firefox", "notepad": "notepad",
                "calculator": "calculatorapp", "task manager": "taskmgr",
                "vscode": "code", "visual studio code": "code",
            }
            proc_name = aliases.get(low, low.replace(".exe", ""))
            try:
                import psutil, os
                killed = 0
                for p in psutil.process_iter(["pid", "name"]):
                    if p.info["pid"] == os.getpid():
                        continue
                    name = (p.info.get("name") or "").lower()
                    if name == proc_name or name == proc_name + ".exe":
                        p.terminate()
                        killed += 1
                return f"Closed {target} ({killed} process(es))."
            except Exception as e:
                return f"Could not close {target}: {e}"
        try:
            import ctypes
            h = ctypes.windll.user32.GetForegroundWindow()
            buf = ctypes.create_unicode_buffer(512)
            ctypes.windll.user32.GetWindowTextW(h, buf, 512)
            if "alan" in buf.value.lower():
                return "Safety stop: ALAN is the active window. I will not close ALAN."
        except Exception:
            pass
        pyautogui.hotkey("alt", "f4")
        return "Closed the active window."
    if _OS == "Darwin":
        pyautogui.hotkey("command", "q")
    else:
        pyautogui.hotkey("alt", "f4")
    return "Closed the active window."

def open_task_manager():
    if _OS == "Windows":
        subprocess.Popen(["taskmgr.exe"], **_WIN_HIDE)
    elif _OS == "Darwin":
        subprocess.Popen(["open", "-a", "Activity Monitor"])
    else:
        for cmd in [["gnome-system-monitor"], ["xfce4-taskmanager"], ["htop"]]:
            if subprocess.run(["which", cmd[0]], capture_output=True).returncode == 0:
                subprocess.Popen(cmd)
                break

'@

$settingsText = $settingsText.Substring(0, $start) + $replacement + $settingsText.Substring($end)
$settingsText = $settingsText.Replace('"close_app":           close_app,', '"close_app":           lambda: close_app(),')
$settingsText = $settingsText.Replace('    value       = params.get("value", None)', '    value       = params.get("value", None)' + [Environment]::NewLine + '    target      = str(params.get("target", "") or params.get("app", "")).strip()')
$settingsText = $settingsText.Replace('    if action == "volume_set":', '    if action == "close_app":' + [Environment]::NewLine + '        return close_app(target)' + [Environment]::NewLine + [Environment]::NewLine + '    if action == "volume_set":')
[IO.File]::WriteAllText($settings, $settingsText)

$controlText = [IO.File]::ReadAllText($control)
$anchor = "def _screen_find(description: str) -> tuple[int, int] | None:"
if (-not $controlText.Contains("def _uia_find(description")) {
    $uia = @'
def _uia_find(description: str) -> tuple[int, int] | None:
    if platform.system() != "Windows":
        return None
    try:
        from pywinauto import Desktop
        needle = (description or "").strip().lower()
        if not needle:
            return None
        for win in Desktop(backend="uia").windows():
            try:
                for el in win.descendants():
                    name = (el.window_text() or "").strip()
                    if name and needle in name.lower():
                        r = el.rectangle()
                        if r.width() > 0 and r.height() > 0:
                            return (int((r.left + r.right) / 2), int((r.top + r.bottom) / 2))
            except Exception:
                continue
    except Exception as e:
        print(f"[ComputerControl] UIA fallback unavailable: {e}")
    return None

'@
    $controlText = $controlText.Replace($anchor, $uia + $anchor)
}
$controlText = $controlText.Replace('def _screen_find(description: str) -> tuple[int, int] | None:' + [Environment]::NewLine + '    api_key = _get_api_key()', 'def _screen_find(description: str) -> tuple[int, int] | None:' + [Environment]::NewLine + '    uia = _uia_find(description)' + [Environment]::NewLine + '    if uia:' + [Environment]::NewLine + '        return uia' + [Environment]::NewLine + [Environment]::NewLine + '    api_key = _get_api_key()')
[IO.File]::WriteAllText($control, $controlText)

Write-Host "ALAN stability + memory + computer-control patch applied successfully."
