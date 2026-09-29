class WakeWordDetector:
    """Wake-word abstraction.

    A real offline custom acoustic model must be plugged in for ALAN phrases.
    """
    def __init__(self, phrases=None):
        self.phrases = phrases or ["Hey ALAN", "Hey man"]
        self.running = False

    def start(self):
        self.running = True
        return True

    def stop(self):
        self.running = False

    def feed(self, audio):
        return False
