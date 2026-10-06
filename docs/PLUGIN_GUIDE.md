# ALAN Plugin Guide

Plugins should expose a small, predictable interface and declare the capabilities they require.

## Plugin checklist
- define inputs and outputs
- validate external input
- request only required permissions
- handle unavailable dependencies
- add tests for normal and failure paths
- document configuration

A plugin must not bypass ALAN's permission or security boundaries.