"""Run basic ALAN environment diagnostics."""
import sys
import platform

print("ALAN diagnostics")
print("Python:", sys.version)
print("OS:", platform.platform())
try:
    import PyQt6
    print("PyQt6: OK")
except Exception as e:
    print("PyQt6:", e)
