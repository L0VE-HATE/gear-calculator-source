"""Copies each weapon package's real normal + lightness textures (extracted from the game with
UModel into extracted/<pkg>/Texture2D) into app/web/models/<pkg>/ as norm.png / light.png, scaled
to 1024 to keep the app small. The 3D viewer (viewer3d.js) uses them for surface bumps and the
game's hand-painted detail. The Eridian rifle package has no such textures and is skipped.
Run in the foreground: python prep_model_textures.py"""
import glob
import os

from PIL import Image

ROOT = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
SRC = os.path.join(ROOT, "extracted")
DST = os.path.join(ROOT, "app", "web", "models")
SIZE = 1024

for pkg in sorted(os.listdir(DST)):
    tex_dir = os.path.join(SRC, pkg, "Texture2D")
    if not glob.glob(os.path.join(tex_dir, "tex_*_light.png")):
        print("%-22s no lightness texture (different material) - skipped" % pkg)
        continue
    for kind in ("norm", "light"):
        found = glob.glob(os.path.join(tex_dir, "tex_*_%s.png" % kind))
        if not found:
            print("%-22s no %s texture - skipped" % (pkg, kind))
            continue
        im = Image.open(found[0]).convert("RGB").resize((SIZE, SIZE), Image.LANCZOS)
        out = os.path.join(DST, pkg, kind + ".png")
        im.save(out, optimize=True)
        print("%-22s %-5s %4d KB" % (pkg, kind, os.path.getsize(out) // 1024))
