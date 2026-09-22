# Credits

This calculator is a free fan project and stands on a lot of other people's work. Thank you to all of them.
Licenses for the bundled third-party software and fonts are listed in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## What is original and what is not

| | |
| --- | --- |
| **Original to this project** | The calculator program (`app/web/index.html`, `sprite2d.js`, `viewer3d.js`), the part naming and colouring system, the Sanity Check, the credits screen, the exe launcher and build scripts (`tools/build_standalone/`), and the data-reading and checking scripts in `tools/` (`upk`, `audit`, `savedecode`, and the small `prep_*.py` scripts). |
| **Derived from other people's work** | Weapon part names and stats (WillowTree#'s `PartsDb.txt`), shield parts and shield formulas (DuncanFogg's data files), the card art, card layout and card font (DuncanFogg), and the stat formulas, which follow the ones used by WillowTree# and DuncanFogg's calculator. Firing-mode and hidden-bonus details were read out of the game's own files. |
| **Game content (Gearbox / 2K)** | 3D models and textures, manufacturer logos, element icons and material colours, all read out of the game's files. The Save File Armory item codes were decoded from a real save. |

## Sources and what was used from each

**DuncanFogg — the original Borderlands 1 Gear Calculator (Flash, 2010)**
http://gearcalc.50webs.com (still online at the time of writing)
His calculator's files were downloaded and decompiled to study how it works. This project uses his
item-card art and part images (enlarged 4x), the card layout and "Prototype" card font, his shield part
data and shield formulas, his part layering order and elemental tint colours, and his stat math as a
reference to check ours against. His site states no license or terms; everything of his is used with credit.
If you are Duncan, or know how to reach him, and want anything changed or removed, please open an issue.

**WillowTree / WillowTree# and its community** (GPL-3.0)
Maintained fork: https://github.com/FromDarkHell/WillowTree-fork — which describes itself as a fork of the
original at https://sourceforge.net/projects/willowtree/
The weapon parts database (`PartsDb.txt`, from WillowTree# 2.4.0) that every weapon part and stat comes from,
and the item-code format used for import and export (read from that fork's `Plugins/ucGears.cs` and
`Inventory/InventoryEntry.cs`), come from WillowTree#. Thank you to everyone who has built and maintained it.

**Borderlands 1 Modding wiki** (CC BY-SA 3.0)
http://blmodding.wikidot.com
Part reference sheets and weapon facts, used for reference and checking. No page text is copied.

**Borderlands Wiki (Fandom)** (CC BY-SA)
https://borderlands.fandom.com
Used to confirm weapon types, manufacturers and rarities of named items. No page text is copied.

## The game

**Gearbox Software / 2K** — Borderlands, its names, weapons, art, models, logos and data. The 3D models,
textures, manufacturer logos, element icons and material colours were read out of the game's own files.
This project is not affiliated with or endorsed by Gearbox Software or 2K.

## Tools and libraries

JPEXS Free Flash Decompiler (FFDec), UModel (UE Viewer) by Konstantin Nosov (Gildor), Three.js, Electron,
Real-ESRGAN, and the Oswald and IBM Plex fonts. Links and licenses are in
[THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## Font note

The "Prototype" card font was extracted from DuncanFogg's calculator, where it is embedded. The font's own
metadata reads "Copyright 2001, free for personal use, freely distributed with Prototype.txt" and does not
name its author. It belongs to its author and is used here for this free, non-commercial fan tool. If you know
who that is, or want it removed, please open an issue.
