from PIL import Image
import os

im = Image.open('tex_logos_and_fx_icons.png').convert('RGBA')
# crop region was (190,0,420,200); use column 4 (x 190+172.5=362.5 to 420), most saturated tier
rows = {
    'Corrosive': (0, 50),
    'Incendiary': (50, 100),
    'Shock': (100, 150),
    'Explosive': (150, 200),
}
x0, x1 = 362, 420
outdir = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..', '..', 'app', 'web', 'vendor', 'uiassets', 'elements'))
for name, (y0, y1) in rows.items():
    cell = im.crop((x0, y0, x1, y1))
    bbox = cell.getbbox()
    if bbox:
        pad = 1
        bbox = (max(0, bbox[0]-pad), max(0, bbox[1]-pad), min(cell.width, bbox[2]+pad), min(cell.height, bbox[3]+pad))
        cell = cell.crop(bbox)
    out = os.path.join(outdir, name + '.png')
    cell.save(out)
    print(name, cell.size, out)
