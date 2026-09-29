# ALAN Architecture

## Layers

### Core
Owns application startup and lifecycle. It should not contain feature implementations.

### AI
Contains provider interfaces and routing. Providers can be swapped without changing UI or action modules.

### Voice
Contains microphone/audio device management, speech-to-text and text-to-speech adapters.

### Wake
Contains wake-word providers. A custom acoustic model can be added without changing the rest of ALAN.

### Actions
Contains callable capabilities of the assistant. Each major capability should remain independently maintainable.

### Memory
Contains persistent assistant memory and storage adapters.

### Plugins
Contains third-party/user extension loading and lifecycle.

### Dashboard
Contains the phone/tablet web interface and remote command API.

### UI
Contains the desktop presentation layer and widgets. UI code should communicate with core services through interfaces rather than embedding business logic.

### Security
Centralizes permissions and confirmations for sensitive operations.

## Foundation strategy

The original Mark-LV project is treated as the functional foundation. Integration should prefer adapters/wrappers where practical so upstream behavior remains traceable and easier to compare.

Do not copy the entire application into one ALAN file.

## Maintenance rule

If a feature has a bug, fix the smallest responsible module. Avoid placing unrelated fixes in main.py.
