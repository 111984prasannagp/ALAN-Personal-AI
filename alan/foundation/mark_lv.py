"""Mark-LV foundation bridge for ALAN.

The upstream Mark-LV implementation stays isolated under vendor/mark_lv.
This module loads it without copying the upstream application into ALAN's
bootstrap or collapsing the project into one large file.
"""

from __future__ import annotations

import importlib.util
import sys
from pathlib import Path


class MarkLVRunner:
    def __init__(self, project_root: Path):
        self.project_root = Path(project_root).resolve()
        self.vendor_root = self.project_root / "vendor" / "mark_lv"
        self._module = None

    def available(self) -> bool:
        return (self.vendor_root / "main.py").is_file()

    def start(self):
        if not self.available():
            raise FileNotFoundError(
                "Mark-LV foundation is not installed at vendor/mark_lv."
            )

        vendor = str(self.vendor_root)
        if vendor not in sys.path:
            sys.path.insert(0, vendor)

        entry = self.vendor_root / "main.py"
        spec = importlib.util.spec_from_file_location("alan_mark_lv_main", entry)
        if spec is None or spec.loader is None:
            raise ImportError(f"Could not load Mark-LV entry point: {entry}")

        module = importlib.util.module_from_spec(spec)
        sys.modules["alan_mark_lv_main"] = module
        spec.loader.exec_module(module)
        self._module = module

        main = getattr(module, "main", None)
        if not callable(main):
            raise AttributeError("Mark-LV main.py does not expose main().")

        return main()
