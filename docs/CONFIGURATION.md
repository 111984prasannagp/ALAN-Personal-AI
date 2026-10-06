# ALAN Configuration Guide

Keep environment-specific settings outside the application code whenever possible.

## Recommended separation
- Source code: application logic and safe defaults.
- Local configuration: machine-specific paths and provider settings.
- Secrets: environment variables or a local secret store.
- Runtime data: local data directories that are excluded from source control.

## Provider changes
AI, voice, and wake-word providers should be replaceable without changing unrelated modules. Document new provider-specific settings next to the provider implementation.
