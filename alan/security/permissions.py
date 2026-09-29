class PermissionManager:
    """Central place for sensitive-action confirmation and permissions."""
    def __init__(self):
        self.rules = {}

    def allowed(self, action):
        return self.rules.get(action, True)
