from abc import ABC, abstractmethod

class AIProvider(ABC):
    name = "base"

    @abstractmethod
    def chat(self, messages, **kwargs):
        raise NotImplementedError
