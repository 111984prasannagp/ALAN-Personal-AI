# ALAN Change Log

## Development rule

Every ALAN code/config/documentation change must be tracked in GitHub.

For each change:
- Update the relevant file in the modular project.
- Record what changed, why it changed, and how it was tested.
- Use a clear commit message describing the change.
- Keep related changes together; do not leave important fixes undocumented.
- Preserve the original Mark-LV attribution/license requirements.
- Keep the ALAN UI frozen unless the user explicitly requests a UI change.

## 2026-10-01

### Stability and computer-control work
- Applied the ALAN stability, persistent-memory bridge, targeted application closing, Task Manager launch, and UI Automation selection patch.
- Applied the live-session reconnect investigation/fix work locally.
- Added temporary interrupt diagnostics locally to identify the source of unexpected startup interruptions; this diagnostic is temporary and should be removed after the root cause is confirmed.

### Testing notes
- Persistent memory was confirmed to recall existing memories and newly remembered preferences during voice testing.
- The remaining issue under investigation is unexpected `Interrupted — listening...` behavior during startup/briefing, which prevents reliable command listening.
