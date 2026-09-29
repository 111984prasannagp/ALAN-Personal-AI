from pathlib import Path
import json
from datetime import datetime

class MemoryStore:
    def __init__(self, path):
        self.path = Path(path)
        self.path.parent.mkdir(parents=True, exist_ok=True)

    def load(self):
        if not self.path.exists():
            return {}
        try:
            return json.loads(self.path.read_text(encoding="utf-8"))
        except Exception:
            return {}

    def set(self, key, value, category="general"):
        data = self.load()
        data[key] = {"value": value, "category": category, "updated": datetime.now().isoformat(timespec="seconds")}
        self.path.write_text(json.dumps(data, indent=2), encoding="utf-8")

    def delete(self, key):
        data = self.load()
        data.pop(key, None)
        self.path.write_text(json.dumps(data, indent=2), encoding="utf-8")
