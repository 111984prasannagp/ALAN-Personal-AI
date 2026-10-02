from pathlib import Path

from alan.config.settings import Settings


def test_settings_defaults_are_independent():
    first = Settings()
    second = Settings()

    first.wake_phrases.append("Temporary phrase")
    first.ui["temporary"] = True

    assert "Temporary phrase" not in second.wake_phrases
    assert "temporary" not in second.ui


def test_settings_save_and_load(tmp_path, monkeypatch):
    import alan.config.settings as settings_module

    config_file = tmp_path / "alan.json"
    monkeypatch.setattr(settings_module, "DATA_DIR", tmp_path)
    monkeypatch.setattr(settings_module, "CONFIG_FILE", config_file)

    original = Settings(user_name="Prasanna")
    original.save()

    loaded = Settings().load()

    assert loaded.user_name == "Prasanna"
    assert loaded.assistant_name == "ALAN"
    assert loaded.app_name == "ALAN Personal AI"


def test_missing_config_uses_defaults(tmp_path, monkeypatch):
    import alan.config.settings as settings_module

    monkeypatch.setattr(settings_module, "DATA_DIR", tmp_path)
    monkeypatch.setattr(settings_module, "CONFIG_FILE", Path(tmp_path) / "missing.json")

    loaded = Settings().load()

    assert loaded.assistant_name == "ALAN"
    assert loaded.version == "1.0.0"
