---

# The Simpsons Game (2007) ps3 edition

---

## Game Overview

*The Simpsons Game* (2007) is a third-person action-adventure game developed by EA and based on the popular animated series *The Simpsons*.

---

## File Structure Overview

### 1. **Textures**
- **Location**: Textures are stored in `.str` archive files, typically bundled and compressed together within the game’s archive system.
- **Tool**: QuickBMS with the `simpsons game str` script extracts both textures and models from the `.str` archive files.
- **Output Format**: Textures are extracted as `.txd` files. These can be converted to PNG format using **Noesis**.

### 2. **Models**
- **Location**: Models are stored within `.str` archive files alongside textures.
- **Extraction Tool**: The `simpsons game str` QuickBMS script extracts both models and textures from the `.str` files.
- **Output Format & Use**: The extracted models can be imported into **Blender** using the Python script designed to handle the .preinstanced model files found in this structure 'build_assets\environs\bargainbin\bargainbin\zone01\export\terrain\'.

### 3. **Audio Files**
- **Location**: Audio files are stored in the `USRDIR\audiostreams` folder.
- **File Format**: These audio files are in `.snu` format.
- **Extraction Tool**: **VGMStream** handles the `.snu` files, converting them to accessible formats like MP3.

### 4. **Cutscenes**
- **Location**: fully animated cutscenes are stored in the `movies` folder.
- **File Format**: The cutscenes are in `.vp6` format.
- **Extraction Tool**: **FFmpeg** can converts `.vp6` video files to MP4.
- **In-Game Animations**: In-game animations are rendered in game, and can not be extracted yet.

---

## License

All assets extracted from *The Simpsons Game 2007* are the property of Electronic Arts and Disney and should be used in compliance with their terms of service and copyright regulations, consisting of do not and never.

---
