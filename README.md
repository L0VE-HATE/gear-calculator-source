# Borderlands Gear Calculator

A free, unofficial fan tool for **Borderlands 1**. Build any weapon or shield from its real parts and see the
in-game item card, the stats, a 2D and 3D picture, and a WillowTree#-style item code you can paste into your
save editor.

> Not affiliated with or endorsed by Gearbox Software or 2K. Borderlands and everything from the game
> (names, art, data) belongs to its owners. See [CREDITS.md](CREDITS.md) for everyone whose work this stands on.

## Use it (Windows)

1. Download **GearCalculator.exe** from the **Releases** section of this repository (right-hand side of the page).
2. Double-click it. The first launch unpacks itself once (a few seconds) into a hidden `.gearcalc` folder
   next to the exe; every launch after that opens almost instantly.
3. Click **Continue** on the credits screen, then build.

Nothing is installed, nothing is written to the registry, and it does not need the game or an internet connection.
The exe is not code-signed, so Windows may show a "SmartScreen" warning the first time: choose
**More info → Run anyway**.

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

## Rights holders

The game art and data included here are used for a free fan tool. If you are a rights holder and want
something removed, open an issue and it will be taken out.
