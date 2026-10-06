# ALAN Development Guide

## Goal
Keep ALAN modular, testable, and safe to extend.

## Workflow
1. Work on one feature or fix at a time.
2. Keep provider-specific code behind interfaces.
3. Add or update tests with behavior changes.
4. Run diagnostics before committing.
5. Keep secrets and local runtime data out of Git.

## Commit standard
Use small, descriptive commits such as `add memory provider interface` or `fix action permission check`. Avoid mixing unrelated changes.

## Review checklist
- Does the change have a single responsibility?
- Does it preserve existing configuration behavior?
- Are sensitive actions protected by explicit permissions?
- Are failure paths handled?
- Is documentation updated when behavior changes?
