"""Safe automatic and explicit long-term memory for ALAN."""

from __future__ import annotations

import re
from typing import Optional

from .store import MemoryStore

_EXPLICIT = re.compile(
    r"\b(?:remember|save|store|keep|memorize)\b.{0,180}",
    re.I,
)
_IMPORTANT = re.compile(
    r"\b(?:my name is|call me|i prefer|i like|i love|i hate|i use|i am using|"
    r"my favorite|whenever i say|when i say|my project is|i study|i work|"
    r"my laptop|my phone|my game)\b",
    re.I,
)


class AutoMemory:
    """Adds automatic memory without changing existing MemoryStore behavior."""

    def __init__(self, store: MemoryStore):
        self.store = store

    def explicit(self, text: str) -> Optional[str]:
        text = (text or "").strip()
        match = _EXPLICIT.search(text)
        if not match:
            return None
        fact = re.sub(
            r"^.*?\b(?:remember|save|store|keep|memorize)\b\s*",
            "",
            text,
            count=1,
            flags=re.I,
        ).strip(" .:,-")
        if not fact:
            fact = text
        key = self._key(fact)
        self.store.set(key, fact, category="explicit")
        return key

    def automatic(self, text: str) -> Optional[str]:
        text = (text or "").strip()
        if not text or len(text) > 300 or not _IMPORTANT.search(text):
            return None
        key = self._key(text)
        self.store.set(key, text, category="automatic")
        return key

    def process(self, text: str) -> Optional[str]:
        return self.explicit(text) or self.automatic(text)

    @staticmethod
    def _key(text: str) -> str:
        key = re.sub(r"[^a-z0-9]+", "_", text.lower()).strip("_")
        return "auto_" + (key[:80] or "memory")
