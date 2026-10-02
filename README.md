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
- Preserve original Mark-LV attribution and license information.
- Keep sensitive actions behind a permission/confirmation layer.
- Make AI, voice, wake-word and UI components replaceable.
- Keep the original foundation traceable instead of hiding its origin.

## Wake phrases

Target phrases:

- **Hey ALAN**
- **Hey man**

A real offline acoustic wake-word model is required to recognize those phrases. Renaming the original Mark-LV `hey_jarvis` model would not change what it recognizes, so ALAN keeps wake detection behind a dedicated provider interface.

## Mark-LV foundation

Original project: https://github.com/FatihMakes/Mark-LV

The Mark-LV project is licensed under **CC BY-NC 4.0**. Its attribution and license must remain with any copied/adapted foundation code. Commercial use of that licensed material is not permitted.

## Current repository status

The professional modular foundation is uploaded. The integration phase is designed to bring the original Mark-LV action, voice, memory, dashboard and UI implementations into the separated ALAN modules while keeping the original source traceable.

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
