class ActionRegistry:
    def __init__(self):
        self.actions = {}

    def register(self, name, handler):
        self.actions[name] = handler

    def run(self, name, **kwargs):
        if name not in self.actions:
            raise KeyError(name)
        return self.actions[name](**kwargs)
