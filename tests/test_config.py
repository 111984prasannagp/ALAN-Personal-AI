from alan.config import settings


def test_identity():
    assert settings.assistant_name == "ALAN"
    assert settings.app_name == "ALAN Personal AI"


def test_wake_phrases():
    assert "Hey ALAN" in settings.wake_phrases
    assert "Hey man" in settings.wake_phrases


def test_version():
    assert settings.version == "1.0.0"
