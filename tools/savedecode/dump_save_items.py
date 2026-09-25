"""Dump every weapon and item record in a BL1 PC save as WillowTree-style clipboard text.

Records are runs of length-prefixed ASCII strings (14 for weapons, 9 for items) followed by
three int32s (quantity, quality|level<<16, equipped). Usage: python dump_save_items.py <path to SaveNNNN.sav>
"""
import struct, sys

path = sys.argv[1]
data = open(path, 'rb').read()


def read_str(off):
    if off + 4 > len(data):
        return None, None
    (ln,) = struct.unpack_from('<i', data, off)
    if ln == 0:
        return '', off + 4
    if ln < 0 or ln > 300 or off + 4 + ln > len(data):
        return None, None
    raw = data[off + 4:off + 4 + ln]
    if raw[-1:] != b'\x00' or not all(32 <= b < 127 for b in raw[:-1]):
        return None, None
    return raw[:-1].decode('ascii'), off + 4 + ln


def record_at(off, n):
    parts, p = [], off
    for _ in range(n):
        s, p = read_str(p)
        if s is None:
            return None
        parts.append(s if s else 'None')
    if p + 12 > len(data):
        return None
    ammo, packed, equipped = struct.unpack_from('<3i', data, p)
    # quality and level share one int: low 16 bits = quality, high 16 bits = level
    return parts, (ammo, packed & 0xFFFF, equipped, packed >> 16)


seen = set()
for kind, n, anchor, slot in (('WEAPON', 14, b'.A_Weapon.', 2), ('ITEM', 9, b'.A_Item.', 1)):
    i = 0
    while True:
        i = data.find(anchor, i)
        if i == -1:
            break
        # walk back to the start of this string, then back `slot` strings to the record start
        for back in range(i, max(i - 200, 0), -1):
            s, end = read_str(back)
            if s is not None and back < i < end:
                break
        else:
            i += 1
            continue
        # find record start: try offsets so that string #slot lands on `back`
        start = None
        for cand in range(back - 1, max(back - 400, 0), -1):
            rec = record_at(cand, n)
            if rec and struct.unpack_from('<i', data, cand)[0] > 0:
                p = cand
                for _ in range(slot):
                    _, p = read_str(p)
                if p == back:
                    start = cand
                    break
        if start is not None and start not in seen:
            seen.add(start)
            parts, ints = record_at(start, n)
            print(f'--- {kind} @0x{start:x}')
            print('\n'.join(parts))
            print('\n'.join(str(x) for x in ints))
        i += 1
