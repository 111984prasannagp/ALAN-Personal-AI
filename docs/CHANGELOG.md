# ALAN Change Log

## Development rule

Every ALAN code/config/documentation change must be tracked in GitHub.

For each change:
- Update the relevant file in the modular project.
- Record what changed, why it changed, and how it was tested.
- Use a clear commit message describing the change.
- Keep related changes together; do not leave important fixes undocumented.
- Keep project ownership, third-party dependencies, and applicable licenses documented accurately.
- Keep the ALAN UI frozen unless the user explicitly requests a UI change.

## 2026-10-01

### Stability and computer-control work
- Applied the ALAN stability, persistent-memory bridge, targeted application closing, Task Manager launch, and UI Automation selection patch.
- Applied the live-session reconnect investigation/fix work locally.
- Added temporary interrupt diagnostics locally to identify the source of unexpected startup interruptions; this diagnostic is temporary and should be removed after the root cause is confirmed.

### Testing notes
- Persistent memory was confirmed to recall existing memories and newly remembered preferences during voice testing.
- The remaining issue under investigation is unexpected `Interrupted — listening...` behavior during startup/briefing, which prevents reliable command listening.


## 2026-10-02

### ALAN independence conversion
- Removed the external foundation bridge from the ALAN lifecycle.
- Removed the external foundation downloader and obsolete foundation-specific scripts.
- Updated architecture and dependency documentation so ALAN starts from its own modular core.
- Updated project ownership documentation: **G.P. PRASANNA — Founder, Creator, and Main Developer**.
- Current repository files no longer intentionally reference the previous assistant project by name.
- Historical Git commits are retained by GitHub and are not rewritten by this cleanup.
