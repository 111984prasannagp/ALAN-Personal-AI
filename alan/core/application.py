from alan.config import settings
from .lifecycle import Lifecycle

class AlanApplication:
    def __init__(self):
        self.settings = settings
        self.lifecycle = Lifecycle(self.settings)

    def run(self):
        self.lifecycle.start()
