"""How much of each weapon part is "composite" (the manufacturer-colored paint) vs "metal", from the game's own mask.

The 3D viewer's shader picks each pixel's tint with mix(metalTint, compositeTint, R/(R+G)) of the weapon package's
mask.png (viewer3d.js). The 2D card only has flat grayscale sprites, so it can't do that per pixel - but it CAN tint
each part image by that part's own average share. This samples mask.png at every triangle of a part's mesh
(3D-area weighted, at the triangle centroid's UV) and prints the composite share R/(R+G) per part.

usage: python prep_part_composite_share.py <models package folder name> [part gltf names...]
   e.g. python prep_part_composite_share.py weap_repeater_pistol body5 mag3 barrel5 action5 sight5
No numpy needed (PIL + struct only).
"""
import json, os, struct, sys
from PIL import Image

MODELS = os.path.join(os.path.dirname(__file__), '..', 'app', 'web', 'models')
CT = {5120: ('b', 1), 5121: ('B', 1), 5122: ('h', 2), 5123: ('H', 2), 5125: ('I', 4), 5126: ('f', 4)}
NC = {'SCALAR': 1, 'VEC2': 2, 'VEC3': 3, 'VEC4': 4}


def accessor(g, blob, idx):
    a = g['accessors'][idx]; bv = g['bufferViews'][a['bufferView']]
    fmt, size = CT[a['componentType']]; n = NC[a['type']]
    stride = bv.get('byteStride') or size * n
    base = bv.get('byteOffset', 0) + a.get('byteOffset', 0)
    return [struct.unpack_from('<' + fmt * n, blob, base + i * stride) for i in range(a['count'])]


def share(pkg, part):
    folder = os.path.join(MODELS, pkg)
    g = json.load(open(os.path.join(folder, part + '.gltf')))
    blob = open(os.path.join(folder, g['buffers'][0]['uri']), 'rb').read()
    mask = Image.open(os.path.join(folder, 'mask.png')).convert('RGB'); mw, mh = mask.size; px = mask.load()
    R = G = area_total = 0.0
    for mesh in g['meshes']:
        for prim in mesh['primitives']:
            pos = accessor(g, blob, prim['attributes']['POSITION']); uv = accessor(g, blob, prim['attributes']['TEXCOORD_0'])
            idx = [i[0] for i in accessor(g, blob, prim['indices'])] if 'indices' in prim else list(range(len(pos)))
            for t in range(0, len(idx) - 2, 3):
                a, b, c = idx[t], idx[t + 1], idx[t + 2]
                ux = [pos[b][k] - pos[a][k] for k in range(3)]; vx = [pos[c][k] - pos[a][k] for k in range(3)]
                cr = (ux[1] * vx[2] - ux[2] * vx[1], ux[2] * vx[0] - ux[0] * vx[2], ux[0] * vx[1] - ux[1] * vx[0])
                ar = 0.5 * (cr[0] ** 2 + cr[1] ** 2 + cr[2] ** 2) ** 0.5
                u = (uv[a][0] + uv[b][0] + uv[c][0]) / 3 % 1.0; v = (uv[a][1] + uv[b][1] + uv[c][1]) / 3 % 1.0
                r, gg, _ = px[min(mw - 1, int(u * mw)), min(mh - 1, int(v * mh))]
                R += ar * r / 255; G += ar * gg / 255; area_total += ar
    return R / (R + G) if R + G > 0 else 0.0, (R + G) / max(area_total, 1e-9)


def write_all(out_path):
    """app/web/partShare.json = {package: {part: [composite share, mask coverage]}} for every part the 2D card tints
    (everything but accessories/grips), used by sprite2d.js for the black-metal materials."""
    table = {}
    for pkg in sorted(os.listdir(MODELS)):
        d = os.path.join(MODELS, pkg)
        if not os.path.exists(os.path.join(d, 'mask.png')): continue          # Eridian rifle has no mask
        parts = {}
        for fn in sorted(os.listdir(d)):
            name = fn[:-5]
            if not fn.endswith('.gltf') or name.startswith(('acc', 'grip', 'Gestalt', 'gestalt')): continue
            f, cov = share(pkg, name)
            if cov >= 0.05: parts[name] = [round(f, 2), round(cov, 2)]
        table[pkg] = parts
    with open(out_path, 'w') as fh: json.dump(table, fh, separators=(',', ':'))
    print('wrote', out_path, sum(len(v) for v in table.values()), 'parts in', len(table), 'packages')


if __name__ == '__main__':
    if sys.argv[1] == '--write':
        write_all(os.path.join(MODELS, '..', 'partShare.json'))
    else:
        pkg = sys.argv[1]
        for part in sys.argv[2:]:
            f, cov = share(pkg, part)
            print('%-12s composite share %.2f   (mask coverage %.2f)' % (part, f, cov))
