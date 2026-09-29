from dataclasses import dataclass, field
from pathlib import Path
import json

from .defaults import ASSISTANT_NAME, USER_NAME, APP_NAME, VERSION, WAKE_PHRASES, UI

ROOT = Path(__file__).resolve().parents[2]
DATA_DIR = ROOT / "data"
CONFIG_FILE = DATA_DIR / "alan.json"

@dataclass
class Settings:
    assistant_name: str = ASSISTANT_NAME
    user_name: str = USER_NAME
    app_name: str = APP_NAME
    version: str = VERSION
    wake_phrases: list[str] = field(default_factory=lambda: WAKE_PHRASES.copy())
    ui: dict = field(default_factory=lambda: UI.copy())

    def load(self) -> "Settings":
        DATA_DIR.mkdir(exist_ok=True)
        if CONFIG_FILE.exists():
            try:
                data = json.loads(CONFIG_FILE.read_text(encoding="utf-8"))
                for key, value in data.items():
                    if hasattr(self, key):
                        setattr(self, key, value)
            except Exception:
                pass
        return self

    def save(self) -> None:
        DATA_DIR.mkdir(exist_ok=True)
        CONFIG_FILE.write_text(
            json.dumps(self.__dict__, indent=2, ensure_ascii=False),
            encoding="utf-8",
        )
