import struct, json, os, sys

PATH = sys.argv[1] if len(sys.argv) > 1 else os.environ.get("BL1_SAVE", "Save0009.sav")  # path to your own Borderlands 1 .sav file

with open(PATH, 'rb') as f:
    data = f.read()

ANCHOR = b"gd_shields.A_Item.Item_Shield"
anchor_pattern = struct.pack('<I', len(ANCHOR) + 1) + ANCHOR + b'\x00'

def read_len_prefixed_str(buf, off):
    (ln,) = struct.unpack_from('<I', buf, off)
    if ln <= 0 or ln > 300 or off + 4 + ln > len(buf):
        return None, None
    raw = buf[off+4:off+4+ln]
    if raw[-1:] != b'\x00':
        return None, None
    raw = raw[:-1]
    try:
        s = raw.decode('ascii')
    except UnicodeDecodeError:
        return None, None
    if not all(32 <= b < 127 for b in raw):
        return None, None
    return s, off + 4 + ln

def find_preceding_string(buf, end_off, max_len=200):
    for L in range(2, max_len):
        start = end_off - L
        prefix_off = start - 4
        if prefix_off < 0:
            break
        (declared_len,) = struct.unpack_from('<I', buf, prefix_off)
        if declared_len == L:
            raw = buf[start:end_off]
            if raw[-1:] != b'\x00':
                continue
            raw2 = raw[:-1]
            try:
                s = raw2.decode('ascii')
            except UnicodeDecodeError:
                continue
            if all(32 <= b < 127 for b in raw2):
                return s, prefix_off
    return None, None

occurrences = []
start = 0
while True:
    idx = data.find(anchor_pattern, start)
    if idx == -1:
        break
    occurrences.append(idx)
    start = idx + 1

print('Found', len(occurrences), 'shield records')

records = []
for idx in occurrences:
    gt_end = idx + len(anchor_pattern)
    grade, _ = find_preceding_string(data, idx)
    if grade is None:
        continue
    off = gt_end
    fields = []
    ok = True
    # Real order confirmed against these exact bytes: Body, Left, Right, Material, Manufacturer(part), Prefix, Title
    for _ in range(7):
        s, next_off = read_len_prefixed_str(data, off)
        if s is None:
            ok = False
            break
        fields.append(s)
        off = next_off
    if not ok:
        continue

    body, left, right, material, manu_part, prefix, title = fields

    # Trailing numeric block (16 bytes), confirmed by comparing all 5 real records' raw hex -
    # specifically by finding the ONE record flagged as currently-equipped (Pangolin Ironclad)
    # and seeing which field flips from 0 to 1: int32 quantity, int16 quality, int16
    # unknown(constant 70 across every record - not quantity/quality/equipped/level, left
    # unexplained but irrelevant to the exported code), int32 equipped, int32 level.
    quantity, quality, _unknown, equipped, level = struct.unpack_from('<ihhii', data, off)

    # Manufacturer for the *export line* is a plain manufacturer path, same convention as
    # weapons ("gd_manufacturers.Manufacturers.<Token>") - derived from the manufacturer part's
    # own src field's trailing token (e.g. ".Manufacturers.Atlas").
    manu_token = manu_part.rsplit('.', 1)[-1]

    code_lines = [
        grade,
        'gd_shields.A_Item.Item_Shield',
        body,
        left,
        right,
        material,
        'gd_manufacturers.Manufacturers.' + manu_token,
        prefix,
        title,
        '1',
        str(quality),
        str(1 if equipped else 0),
        str(level),
    ]

    records.append({
        'grade': grade, 'body': body, 'left': left, 'right': right, 'material': material,
        'manufacturer': manu_token, 'prefix': prefix, 'title': title,
        'quality': quality, 'equipped': equipped, 'level': level,
        'code': '\n'.join(code_lines),
    })

for r in records:
    print(r['grade'], '| body=', r['body'], '| manu=', r['manufacturer'], '| quality=', r['quality'], '| equipped=', r['equipped'], '| level=', r['level'])

with open("shield_builds.json", "w") as f:
    json.dump(records, f, indent=1)
