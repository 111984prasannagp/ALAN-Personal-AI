# ALAN Security Model

ALAN can interact with local systems, so sensitive actions must be treated as privileged operations.

## Rules
- Never store API keys, tokens, passwords, or private data in source control.
- Keep permissions explicit and deny by default where practical.
- Require confirmation for destructive or externally visible actions.
- Validate inputs before passing them to system or integration adapters.
- Log useful operational events without exposing secrets.

## Extension rule
New plugins and actions should declare what capabilities they require and should not silently gain broader system access.
