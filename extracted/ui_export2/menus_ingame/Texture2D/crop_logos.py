from PIL import Image
import os

im = Image.open('tex_logos_and_fx_icons.png').convert('RGBA')
cells = {
 'Torgue': (0,0,95,32),
 'Jakobs': (95,0,190,32),
 'Maliwan': (95,32,190,70),
 'Vladof': (0,70,95,105),
 'tediore': (95,70,190,105),
 'Dahl': (0,105,95,145),
 'SandSMunitions': (95,145,190,180),
 'Atlas': (95,180,190,215),
 'Gearbox': (95,255,190,295),
 'Hyperion': (95,295,190,340),
}
outdir = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..', '..', 'app', 'web', 'vendor', 'uiassets', 'logos'))
for name, (x0, y0, x1, y1) in cells.items():
    cell = im.crop((x0, y0, x1, y1))
    bbox = cell.getbbox()
    if bbox:
        pad = 1
        bbox = (max(0, bbox[0]-pad), max(0, bbox[1]-pad), min(cell.width, bbox[2]+pad), min(cell.height, bbox[3]+pad))
        cell = cell.crop(bbox)
    out = os.path.join(outdir, name + '.png')
    cell.save(out)
    print(name, cell.size, out)
