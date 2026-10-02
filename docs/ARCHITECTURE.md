# ALAN Architecture

## Project ownership

**Founder & Creator:** G.P. PRASANNA  
**Main Developer:** G.P. PRASANNA

## Layers

### Core
Owns application startup, lifecycle, component registration, and shutdown orchestration.

### AI
Contains provider interfaces and routing. Providers can be swapped without changing UI or action modules.

### Voice
Contains microphone/audio device management, speech-to-text and text-to-speech adapters.

### Wake
Contains wake-word providers. A custom acoustic model can be added without changing the rest of ALAN.

### Actions
Contains callable capabilities of the assistant. Each major capability remains independently maintainable.

### Memory
Contains persistent assistant memory and storage adapters.

### Plugins
Contains third-party/user extension loading and lifecycle.

### Dashboard
Contains the phone/tablet web interface and remote command API.

### UI
Contains the desktop presentation layer and widgets. UI code communicates with core services through interfaces rather than embedding business logic.

### Security
Centralizes permissions and confirmations for sensitive operations.

## Independence rule

ALAN is being developed as its own modular personal AI project. Runtime startup must not download, import, execute, or depend on another assistant project's source tree.

Feature implementations belong inside ALAN's own modules or use clearly identified third-party libraries through their published APIs.

## Maintenance rule

If a feature has a bug, fix the smallest responsible module. Avoid placing unrelated fixes in main.py.

Every meaningful change is recorded in docs/CHANGELOG.md and committed to the ALAN GitHub repository.
