from pathlib import Path

from ..foundation.mark_lv import MarkLVRunner


class Lifecycle:
    """High-level ALAN application lifecycle."""

    def __init__(self, settings):
        self.settings = settings
        self.components = []
        self.project_root = Path(__file__).resolve().parents[2]
        self.mark_lv = MarkLVRunner(self.project_root)

    def start(self):
        print(f"{self.settings.app_name} {self.settings.version}")
        print(f"Assistant: {self.settings.assistant_name}")

        if self.mark_lv.available():
            print("Mark-LV foundation detected.")
            print("Starting ALAN foundation...")
            return self.mark_lv.start()

        print("Modular architecture initialized.")
        print("Mark-LV foundation not found.")
        print("Run: powershell -ExecutionPolicy Bypass -File scripts\\sync_mark_lv.ps1")
