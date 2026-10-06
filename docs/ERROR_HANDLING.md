# ALAN Error Handling

Errors should be handled at the boundary where they can be understood and recovered from.

## Principles
- Do not silently swallow failures.
- Keep user-facing messages clear and actionable.
- Preserve useful diagnostic context without exposing secrets.
- Treat unavailable optional integrations as isolated failures.
- Avoid retry loops without bounded limits.
