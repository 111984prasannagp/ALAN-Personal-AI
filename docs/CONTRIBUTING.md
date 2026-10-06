# ✦ Contributing to ALAN

ALAN is maintained as a modular personal AI project by **G.P. PRASANNA**.

## Development flow

1. Pick one focused improvement.
2. Change the smallest responsible module.
3. Add or update a test when practical.
4. Run diagnostics/tests before committing.
5. Use a clear commit message.
6. Record meaningful changes in `docs/CHANGELOG.md`.

## Module rule

Keep features separated:

- 🧠 AI → `alan/ai/`
- 💾 Memory → `alan/memory/`
- 🎙️ Voice → `alan/voice/`
- 💻 Computer/system → `alan/system/` and `alan/actions/`
- 🧩 Plugins → `alan/plugins/`
- 🛡️ Security → `alan/security/`
- 🎨 UI → `alan/ui/`

Avoid putting feature logic directly into `main.py`.

## UI rule

The current ALAN application UI is frozen. Do not redesign it unless the project owner explicitly requests a UI change.

## Commit style

Use concise messages such as:

`feat: add memory search`  
`fix: prevent unsafe application close`  
`test: cover settings identity`  
`docs: update architecture`

## Ownership

**Founder & Creator:** G.P. PRASANNA  
**Main Developer:** G.P. PRASANNA

ALAN is a personal, non-commercial project.


## Commit quality
Use a clear imperative commit message and keep each commit focused on one logical change.
