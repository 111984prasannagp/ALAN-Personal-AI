# Wake Word

ALAN targets:

- Hey ALAN
- Hey man

The acoustic detector is intentionally isolated under alan/wake/.

The original Mark-LV detector uses a pretrained model for hey_jarvis. A text rename does not retrain that model. A genuine offline ALAN wake phrase therefore requires a compatible custom model/provider.

The rest of ALAN should depend only on the detector interface, allowing the model to be replaced later without changing the application, UI, memory or actions.
