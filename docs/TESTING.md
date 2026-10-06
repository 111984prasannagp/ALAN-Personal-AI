# ALAN Testing Guide

## Testing priorities
ALAN should test core behavior before optional integrations.

### Core
- configuration loading
- action registration
- permission checks
- memory read/write behavior
- provider selection and failure handling

### Integrations
External AI, voice, wake-word, and OS adapters should be tested independently so unavailable services do not break the core application.

## Local checks
Run the project diagnostics and the available automated tests before pushing changes.

## Test principle
Tests should verify observable behavior rather than implementation details, making refactors safer.
