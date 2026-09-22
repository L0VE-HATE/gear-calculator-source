from PIL import Image
import os

im = Image.open('tex_weapons_menu_elements.png').convert('RGBA')
cells = {
    'pistol': (0, 198, 140, 228),
    'rifle': (140, 198, 280, 228),
    'shotgun': (0, 228, 140, 258),
    'sniper': (140, 228, 280, 258),
    'smg': (0, 258, 140, 288),
}
outdir = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..', '..', 'app', 'web', 'vendor', 'uiassets', 'weapontypes'))
os.makedirs(outdir, exist_ok=True)
for name, box in cells.items():
    cell = im.crop(box)
    bbox = cell.getbbox()
    if bbox:
        pad = 2
        bbox = (max(0, bbox[0]-pad), max(0, bbox[1]-pad), min(cell.width, bbox[2]+pad), min(cell.height, bbox[3]+pad))
        cell = cell.crop(bbox)
    out = os.path.join(outdir, name + '.png')
    cell.save(out)
    print(name, cell.size, out)
