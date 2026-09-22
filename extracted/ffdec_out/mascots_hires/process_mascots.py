from PIL import Image
import os

# chid -> (output filename)
mapping = {
    236: 'pistol',      # cop hat + revolver
    239: 'sniper',      # cowboy hat + scoped rifle
    242: 'smg',         # goggles + SMG
    247: 'shotgun',     # cap + pump shotgun
    265: 'grenade',     # mesh helmet + grenade in hand
    267: 'rocket',      # mesh helmet + ammo cans/rockets
}

outdir = os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', '..', 'app', 'web', 'vendor', 'uiassets', 'mascots'))
os.makedirs(outdir, exist_ok=True)

for chid, name in mapping.items():
    im = Image.open(f'{chid}.png').convert('RGBA')
    bbox = im.getbbox()
    if bbox:
        pad = 10
        bbox = (max(0, bbox[0]-pad), max(0, bbox[1]-pad), min(im.width, bbox[2]+pad), min(im.height, bbox[3]+pad))
        im = im.crop(bbox)
    im.thumbnail((400, 400), Image.LANCZOS)
    out = os.path.join(outdir, name + '.png')
    im.save(out)
    print(name, im.size, out)
