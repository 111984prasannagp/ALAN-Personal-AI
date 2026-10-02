"""ALAN application lifecycle.

The lifecycle owns startup/shutdown orchestration only. Feature implementations
live in their dedicated ALAN modules and are registered through the component
layer as those modules become available.
"""


class Lifecycle:
    """High-level lifecycle for the ALAN Personal AI application."""

    def __init__(self, settings):
        self.settings = settings
        self.components = []

    def register(self, component):
        """Register an ALAN component for future lifecycle management."""
        self.components.append(component)

    def start(self):
        print(f"{self.settings.app_name} {self.settings.version}")
        print(f"Assistant: {self.settings.assistant_name}")
        print("ALAN modular core initialized.")
        print("Feature modules are loaded through the ALAN component architecture.")

        for component in self.components:
            start = getattr(component, "start", None)
            if callable(start):
                start()
