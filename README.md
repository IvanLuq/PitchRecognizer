# Pitch Recognizer (Apple Watch)

Pitch Recognizer is a minimal **watchOS** app that listens through the Apple Watch microphone and shows the nearest musical note in real time (e.g. C, F#, Bb), based on a configurable A4 tuning and your preferred accidentals (sharps or flats).

The app is designed to be **standalone on the watch**, quick to use, and easy to read at a glance.

---

## Features

- 🎚 **One-tap pitch detection**  
  Tap the big circle to start/stop listening. While listening, the ring turns green and the detected note is shown inside the circle.

- 🎵 **Real-time pitch → note mapping**  
  Uses a simple autocorrelation-based pitch detector to estimate the fundamental frequency and convert it to the nearest musical note, with octave shown as a subscript (e.g. `A₄`).

- ⚙️ **Configurable tuning (A4 base frequency)**  
  Change the base frequency used for tuning (e.g. 440 Hz → 432–660 Hz range). Long-press the value to reset back to **440 Hz**.

- #/♭ **Sharps or flats**  
  Choose whether notes are displayed with sharps (`C#`, `F#`) or flats (`Db`, `Gb`).

- 🕹 **Digital Crown sensitivity control**  
  Use the Digital Crown to adjust microphone **sensitivity** (how loud a sound must be to be treated as valid pitch). A small HUD shows the current sensitivity percentage while scrolling.

- 💾 **Persistent settings**  
  Tuning, accidentals and sensitivity are stored using `UserDefaults`, so your preferences are preserved between sessions.

---

## Screens

### Main Pitch Screen

- Large circle in the center:
  - **Idle:** note label shows `--` and subtitle “Tap to start”.
  - **Listening:** circle stroke turns green, and the current note (e.g. `E♭₄`) is shown in large text.
- Tap the circle to **start/stop** pitch recognition.
- If the app cannot detect a clean pitch (too quiet / noisy), it falls back to `--`.

**Digital Crown:**

- Rotate to change microphone **sensitivity** (0–100%).
- A small percentage HUD appears while scrolling.
- Sensitivity is saved automatically.

### Settings Screen

Accessible by swiping horizontally (page-style `TabView`) to the settings tab.

Sections:

1. **Base Frequency**
   - `−` / `+` buttons to decrease/increase A4 tuning in Hz.
   - Long-press the center value label to **reset to 440 Hz**.
   - Long-press on `−` or `+` triggers a repeat “fast scroll” (bigger steps).

2. **Accidentals**
   - Picker to choose:
     - `Sharps (#)`
     - `Flats (♭)`

3. **About**
   - Short description of what the app does.
   - Tip about using the scroller to modify sensitivity.
   - Credits.

---

## How it works (high level)

- Uses **AVAudioEngine** to read microphone samples in real time.
- For each audio buffer:
  - Computes RMS amplitude and compares it to a threshold derived from the **sensitivity** slider.
  - If loud enough, runs a **simple autocorrelation** over a frequency range (≈80–1000 Hz) to estimate the best lag and thus the fundamental frequency.
  - Converts frequency → **MIDI note number** relative to A4 using the current base frequency from settings.
  - Maps MIDI to a note name array (sharp or flat set) and adds an octave as a Unicode subscript.
- If no reliable pitch is detected (too quiet, too noisy, or correlation too low), the UI shows `--`.

> Note: This is intentionally a simple pitch detector, best suited for **monophonic, relatively clean tones** (voice, single instrument, etc.).

---

## Requirements

- Xcode with watchOS development support.
- An Apple Watch running a recent version of watchOS that supports:
  - `AVAudioEngine`
  - `AVAudioSession` / `AVAudioApplication` record permissions
- A physical Apple Watch is recommended for real-world testing (pitch detection from the simulator is not available).

---

## Project structure

Main files:

- `PitchRecognizerApp.swift`  
  App entry point. Sets up a `TabView` with:
  - `MainPitchView` (pitch detection)
  - `SettingsView` (tuning + accidentals)

- `MainPitchView.swift`  
  UI for the main pitch circle, note display, status text, error messages and Digital Crown sensitivity handling.

- `SettingsView.swift`  
  UI for base frequency control, accidentals picker and about section, using `@AppStorage` for persistence.

- `AppSettings.swift`  
  `AppSettings` model and `AccidentalPreference` enum (sharps/flats).

- `PitchRecognizerViewModel.swift`  
  Observable object that:
  - Manages microphone permissions.
  - Starts/stops `AVAudioEngine`.
  - Processes audio buffers and estimates pitch.
  - Converts frequency → note string.
  - Stores sensitivity in `UserDefaults`.

---

## Usage

1. Build and run the **watchOS target** on your Apple Watch.
2. On the watch:
   - Open **Pitch Recognizer**.
   - Tap the big circle to grant microphone permission (first run) and start listening.
   - Play a note or sing; the detected note appears inside the circle.
   - Rotate the Digital Crown to adjust sensitivity if it’s not picking up or is too reactive.
   - Swipe to the settings page to tweak A4 base frequency and accidentals.

---
