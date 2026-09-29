class AIProviderRouter:
    def __init__(self):
        self.providers = {}
        self.active = None

    def register(self, provider):
        self.providers[provider.name] = provider
        if self.active is None:
            self.active = provider.name

    def chat(self, messages, **kwargs):
        if not self.active:
            raise RuntimeError("No AI provider configured.")
        return self.providers[self.active].chat(messages, **kwargs)
