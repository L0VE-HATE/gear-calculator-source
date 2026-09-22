"""Minimal UE3 (Borderlands 1, package v584) .upk reader: dumps an export's tagged properties.

UModel's -dump only handles meshes/textures/materials, so WeaponPartDefinition / FiringMode /
Projectile objects (the "hidden" data PartsDb.txt doesn't carry - homing, firing mode, ...) can't be
seen through it. Works only on UNCOMPRESSED packages (gd_weap_alien_rifle.upk is).

usage:  python read_props.py <package.upk> [ExportNameSubstring ...]
        (no names = list every export as  index  class  name)
"""
import struct, sys


class Pkg:
    def __init__(self, path):
        self.b = open(path, 'rb').read()
        b = self.b
        tag, self.ver, self.lic, self.hsz = struct.unpack_from('<IHHI', b, 0)
        assert tag == 0x9E2A83C1, 'not a upk'
        o = 12
        n = struct.unpack_from('<i', b, o)[0]; o += 4
        o += n if n > 0 else -2 * n                     # folder name
        self.flags, = struct.unpack_from('<I', b, o); o += 4
        nc, no, ec, eo, ic, io = struct.unpack_from('<6I', b, o)
        # names
        self.names = []
        o = no
        for _ in range(nc):
            n = struct.unpack_from('<i', b, o)[0]; o += 4
            if n > 0: s = b[o:o + n - 1].decode('latin1'); o += n
            else: s = b[o:o - 2 * n - 2].decode('utf-16le'); o += -2 * n
            o += 8
            self.names.append(s)
        # imports
        self.imports = []
        o = io
        for _ in range(ic):
            cp, _, cn, _, outer, on, _ = struct.unpack_from('<iiiiiii', b, o); o += 28
            self.imports.append((self.names[cn], self.names[on], outer))
        # exports
        self.exports = []
        o = eo
        for _ in range(ec):
            cls, sup, outer, on, onn, arch, fl, size, off = struct.unpack_from('<iiiiiiQii', b, o); o += 40
            o += 4                                       # export flags
            g, = struct.unpack_from('<i', b, o); o += 4 + 4 * g
            o += 16 + 4                                  # package guid + package flags
            self.exports.append(dict(cls=cls, outer=outer, name=self.names[on], num=onn, size=size, off=off))

    def ref(self, i):
        if i == 0: return 'None'
        if i > 0: e = self.exports[i - 1]; return '%s:%s' % (self.cname(e['cls']), e['name'])
        c, n, _ = self.imports[-i - 1]; return 'imp:%s:%s' % (c, n)

    def cname(self, i):
        if i == 0: return 'Class'
        return self.exports[i - 1]['name'] if i > 0 else self.imports[-i - 1][1]

    def path(self, i):
        e = self.exports[i]; parts = [e['name']]
        while e['outer'] > 0:
            e = self.exports[e['outer'] - 1]; parts.append(e['name'])
        return '.'.join(reversed(parts))

    def props(self, idx):
        e = self.exports[idx]; b = self.b; o = e['off'] + 4   # skip NetIndex
        end = e['off'] + e['size']; out = []
        while o + 8 <= end:
            ni, nn = struct.unpack_from('<ii', b, o); o += 8
            name = self.names[ni]
            if name == 'None': break
            ti, _, size, ai = struct.unpack_from('<iiii', b, o); o += 16
            typ = self.names[ti]; extra = ''
            if typ == 'StructProperty': extra = self.names[struct.unpack_from('<i', b, o)[0]]; o += 8
            if typ == 'BoolProperty':                     # v584: value is a 4-byte UBOOL after the tag, not counted in Size
                out.append((name, typ, extra, bool(struct.unpack_from('<I', b, o)[0]))); o += 4 + size; continue
            data = b[o:o + size]; o += size
            if typ == 'ObjectProperty' and size == 4: v = self.ref(struct.unpack('<i', data)[0])
            elif typ == 'IntProperty' and size == 4: v = struct.unpack('<i', data)[0]
            elif typ == 'FloatProperty' and size == 4: v = round(struct.unpack('<f', data)[0], 5)
            elif typ == 'NameProperty' and size == 8: v = self.names[struct.unpack('<i', data[:4])[0]]
            elif typ == 'ByteProperty' and size == 1: v = data[0]
            elif typ == 'ByteProperty' and size == 8: v = self.names[struct.unpack('<i', data[:4])[0]]
            elif typ == 'StrProperty' and size >= 4:
                n = struct.unpack_from('<i', data)[0]
                v = data[4:4 + n - 1].decode('latin1') if n > 0 else data[4:4 - 2 * n - 2].decode('utf-16le')
            elif typ == 'ArrayProperty':
                n = struct.unpack_from('<i', data)[0]; v = 'array[%d] %s' % (n, data[4:4 + 24].hex())
                if n and (size - 4) == 4 * n: v = [self.ref(x) for x in struct.unpack_from('<%di' % n, data, 4)]
            else: v = data[:32].hex()
            out.append((name + ('[%d]' % ai if ai else ''), typ, extra, v))
        return out


def _tagged(p, o, end, depth=0):
    """Recursive tagged-property parse (structs inside structs, arrays of refs or of structs). Returns (dict, offset)."""
    b = p.b; out = {}
    while o + 8 <= end:
        ni, _ = struct.unpack_from('<ii', b, o); o += 8
        nm = p.names[ni]
        if nm == 'None': break
        ti, _, size, ai = struct.unpack_from('<iiii', b, o); o += 16
        typ = p.names[ti]; sname = ''
        if typ == 'StructProperty': sname = p.names[struct.unpack_from('<i', b, o)[0]]; o += 8
        if typ == 'BoolProperty': out[nm] = bool(struct.unpack_from('<I', b, o)[0]); o += 4 + size; continue
        data_start = o; data = b[o:o + size]; o += size
        key = nm + ('[%d]' % ai if ai else '')
        if typ == 'ObjectProperty' and size == 4: v = p.ref(struct.unpack('<i', data)[0]); out[key + '#idx'] = struct.unpack('<i', data)[0]
        elif typ == 'IntProperty' and size == 4: v = struct.unpack('<i', data)[0]
        elif typ == 'FloatProperty' and size == 4: v = round(struct.unpack('<f', data)[0], 5)
        elif typ == 'NameProperty' and size == 8: v = p.names[struct.unpack('<i', data[:4])[0]]
        elif typ == 'ByteProperty' and size == 8: v = p.names[struct.unpack('<i', data[:4])[0]]
        elif typ == 'ByteProperty' and size == 1: v = data[0]
        elif typ == 'StrProperty' and size >= 4:
            n = struct.unpack_from('<i', data)[0]; v = data[4:4 + n - 1].decode('latin1') if n > 0 else data[4:4 - 2 * n - 2].decode('utf-16le')
        elif typ == 'StructProperty' and depth < 6:
            try: v, _ = _tagged(p, data_start, data_start + size, depth + 1)
            except Exception: v = data[:24].hex()
        elif typ == 'ArrayProperty' and depth < 6:
            n = struct.unpack_from('<i', data)[0]
            if n == 0: v = []
            elif size - 4 == 4 * n: v = [p.ref(x) for x in struct.unpack_from('<%di' % n, data, 4)]
            else:
                q = data_start + 4; v = []
                try:
                    for _ in range(n):
                        d, q = _tagged(p, q, data_start + size, depth + 1); v.append(d)
                except Exception: v = 'array[%d] (undecoded)' % n
        else: v = data[:16].hex()
        out[key] = v
    return out, o


def deep(p, idx):
    e = p.exports[idx]
    return _tagged(p, e['off'] + 4, e['off'] + e['size'])[0]


if __name__ == '__main__':
    p = Pkg(sys.argv[1]); want = sys.argv[2:]
    for i, e in enumerate(p.exports):
        if not want:
            print(i, p.cname(e['cls']), p.path(i)); continue
        if any(w.lower() in p.path(i).lower() for w in want):
            print('==', i, p.cname(e['cls']), p.path(i))
            for pr in p.props(i): print('    ', pr)
