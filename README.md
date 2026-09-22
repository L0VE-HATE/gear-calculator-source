# Borderlands Gear Calculator

A free, unofficial fan tool for **Borderlands 1**. Build any weapon or shield from its real parts and see the
in-game item card, the stats, a 2D and 3D picture, and a WillowTree#-style item code you can paste into your
save editor.

> Not affiliated with or endorsed by Gearbox Software or 2K. Borderlands and everything from the game
> (names, art, data) belongs to its owners. See [CREDITS.md](CREDITS.md) for everyone whose work this stands on.

## TL;DR

- **Just want to use the app?** Skip this repo — download the ready-to-run exe from [gear-calculator](https://github.com/L0VE-HATE/gear-calculator) instead. This repo is the source code behind it.
- Builds any Borderlands 1 weapon/shield from real parts and shows the real item card, stats, a 2D/3D picture, and a WillowTree#-style code.
- Your own code to use/change freely (MIT); game content and DuncanFogg's files are credited separately, not covered by that license.

## Get it

This repo is the source code only - there's no exe here. Grab the ready-to-run Windows app from
**[gear-calculator](https://github.com/L0VE-HATE/gear-calculator)**, which has the download and setup steps.

**Using it:** pick **Weapons** or **Shields**, choose a type, then choose parts from the dropdowns or the part
tiles. The item card updates as you go. The **Code** tab holds the item code: copy it into WillowTree#'s item
editor, or paste a code there to load it back. The Save File Armory (below the card) loads a ready-made build in one click.

## What it does

- Every weapon type (Eridian included) and Shields, with every part slot, prefix, title, material and manufacturer.
- The item card with damage, accuracy, fire rate, reload, magazine, crit and part effects.
- 2D card picture and an interactive 3D view.
- Import and export of WillowTree# item codes.
- A Sanity Check that warns when a build is unlikely to load in the game.
- A Save File Armory of 118 weapons and 5 shields decoded from a real save.

## Known limitations

- **Windows only** (the exe). The calculator itself is a web page and can be opened in a browser (see below).
- **Class Mods are not supported** (the original calculator never finished them either), and shields have no 3D view.
- **Some colours are approximate.** Most weapon skins use the game's real material colours, but a few (Kyros' Power,
  Eridian materials, some promo weapons) fall back to estimated colours. The 3D lighting was tuned by eye, not
  compared against the game.
- **2D card color placement:** most weapons' 3D models match the real look closely (aside from lighting/texture
  grain); the 2D card's colors are usually right, but not always mapped to the correct part of the gun - a
  skin's two colors can end up swapped between parts. Not yet fixed.
- **Critical damage** when a crit-boosting part is on a weapon that already has a type bonus is calculated by
  multiplying the two; whether the game adds or multiplies them was not verified.
- **The Sanity Check is a guide, not a guarantee.** Some combinations (for example Eridian barrels borrowed from
  another Eridian type) were not tested in the game.
- The 2D card art comes from the original 2010 calculator, which had no Eridian part pictures.

## Folders

| Folder | What it is |
| --- | --- |
| `app/` | The calculator. `app/web/` is the whole program: `index.html`, `gearData.json` (every part and stat), `viewer3d.js`, `sprite2d.js`, plus fonts, images and 3D models. `app/app.py` and `GearCalculator.spec` are an older Python launcher, kept for reference. |
| `tools/build_standalone/` | Builds the single `GearCalculator.exe` (Electron launcher + the files in `app/web`). |
| `tools/upk/`, `tools/audit/`, `tools/savedecode/` | Scripts that read game data and check the data for mistakes. |
| `tools/ffdec/`, `tools/umodel/` | Third-party programs used to open the game's and the original calculator's files (their own licenses are inside). |
| `extracted/` | Raw material pulled from the game and from DuncanFogg's original calculator while building this. |

## Run or change it from source

Quick look, no build: serve `app/web` and open it in a browser.

```
cd app/web
python -m http.server 8000
```

then open `http://localhost:8000`.

Build your own exe (Windows, Python 3; it downloads Electron the first time):

```
python tools/build_standalone/build.py "C:/some/scratch/folder"
```

The finished exe is written to `out/GearCalculator.exe` inside that folder.

The data scripts in `tools/` need your own copy of the game or of WillowTree#. Set these before running them:

| Variable | Points to |
| --- | --- |
| `BL1_COOKEDPC` | Your Borderlands 1 `WillowGame/CookedPC` folder |
| `WILLOWTREE_PARTSDB` | `PartsDb.txt` from your WillowTree# folder |
| `BL1_SAVE` | Your own `.sav` file (only for `savedecode`) |

## Credits and licensing

This project's own code is [MIT licensed](LICENSE) - use, change and redistribute it freely. That does not
cover the Borderlands game content (Gearbox Software / 2K), DuncanFogg's original files, or the third-party
software and fonts listed in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md), which stay under their own
owners' rights. Thanks to DuncanFogg, WillowTree#, the Borderlands 1 Modding wiki, the Borderlands Wiki and
the makers of the tools this uses: see [CREDITS.md](CREDITS.md).

## Contributing

Found bad data or a math mistake? Open an issue. Pull requests are welcome - if you're correcting something
about how the game actually behaves, please cite where that came from (PartsDb.txt, a wiki page, in-game
testing, etc.), the same standard the existing data was held to.

## Rights holders

The game art and data included here are used for a free fan tool. If you are a rights holder and want
something removed, open an issue and it will be taken out.
