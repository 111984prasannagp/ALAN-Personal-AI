from alan.config import settings

def test_identity():
    assert settings.assistant_name == "ALAN"
