# ALAN — Professional Personal AI

**Founder & Creator:** G.P. PRASANNA  
**Main Developer:** G.P. PRASANNA  
**Project:** ALAN Personal AI  
**Project type:** Personal / non-commercial

ALAN is a personal AI assistant project created and developed by **G.P. PRASANNA**. The current repository is being progressively rebuilt into an independent, modular ALAN implementation.

> Personal / non-commercial project.

## Architecture

The codebase is intentionally separated so individual systems can be changed without turning the project into one giant Python file.

```
ALAN-Personal-AI/
├── alan/
│   ├── ai/          # LLM providers and routing
│   ├── actions/     # Action registry and adapters
│   ├── config/      # Identity and settings
│   ├── core/        # Application lifecycle
│   ├── dashboard/   # Phone/tablet interface
│   ├── memory/      # Persistent memory
│   ├── plugins/     # Plugin manager
│   ├── security/    # Permissions
│   ├── system/      # OS integration
│   ├── ui/          # Desktop UI
│   ├── utils/       # Shared utilities
│   ├── voice/       # STT/TTS/audio
│   └── wake/        # Wake-word subsystem
├── docs/             # Architecture and maintenance docs
├── scripts/          # Startup and diagnostics
├── tests/            # Automated tests
├── data/             # Local runtime data
└── main.py           # Small bootstrap only
```

## Design principles

- Keep feature systems in separate modules.
- Keep `main.py` as a bootstrap only.
- Keep sensitive actions behind a permission/confirmation layer.
- Make AI, voice, wake-word and UI components replaceable.
- Keep ALAN's project identity and ownership clear.

## Wake phrases

Target phrases:

- **Hey ALAN**
- **Hey man**

Wake detection is kept behind a dedicated provider interface so the acoustic model can be changed without changing the rest of ALAN.

## Current repository status

The repository is being developed as an independent, modular ALAN implementation created by G.P. PRASANNA.

## Local development

```bat
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements-alan.txt
python main.py
```

For diagnostics:

```bat
scripts\diagnose.bat
```
