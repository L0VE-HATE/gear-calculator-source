# Third-party notices

Software and fonts included in this repository, or packed into `GearCalculator.exe`, under their own licenses.
Game content (Gearbox / 2K) and DuncanFogg's files are covered in [CREDITS.md](CREDITS.md).

| Component | Used for | License | Where |
| --- | --- | --- | --- |
| [Three.js](https://threejs.org) r160 (and its GLTFLoader, OrbitControls, BufferGeometryUtils add-ons) | 3D weapon viewer | MIT | `app/web/vendor/three/` (license text: `LICENSE` in that folder) |
| [Oswald](https://github.com/googlefonts/OswaldFont) | Interface font | SIL Open Font License 1.1 | `app/web/vendor/fonts/` (license text: `OFL-Oswald.txt`) |
| [IBM Plex Sans / Mono](https://github.com/IBM/plex) | Interface fonts | SIL Open Font License 1.1 | `app/web/vendor/fonts/` (license text: `OFL-IBM-Plex.txt`) |
| [Electron](https://www.electronjs.org) 44.4.3 (includes Chromium) | The browser engine packed into the exe | MIT (Electron); Chromium's mixed licenses | Packed inside `GearCalculator.exe`; its `LICENSE` and `LICENSES.chromium.html` are unpacked beside it on first launch |
| [JPEXS Free Flash Decompiler (FFDec)](https://github.com/jindrapetrik/jpexs-decompiler) | Reading Flash files while building the project | GPL-3.0 (its libraries carry their own licenses) | `tools/ffdec/` — unmodified copy; license files are inside. Source code is at the link. |
| [UModel (UE Viewer)](https://www.gildor.org/en/projects/umodel) by Konstantin Nosov (Gildor) | Reading the game's Unreal packages while building the project | MIT | `tools/umodel/` — unmodified copy; `LICENSE.txt` and `readme.txt` are inside. Its `SDL2` DLLs are included as shipped. |
| [Real-ESRGAN](https://github.com/xinntao/Real-ESRGAN) | Enlarging the 2D part images 4x (a one-off step; the tool itself is not included) | BSD-3-Clause | Not included |

These are only the components this project uses directly. If you spot a missing or wrong notice, please open an issue.

`tools/ffdec/` and `tools/umodel/` are not needed to run the calculator. They are here so the extraction steps
can be repeated.
