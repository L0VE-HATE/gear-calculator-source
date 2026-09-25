"""List every weapon part PartsDb has that gearData.json can't resolve by its exact path.

A missing part makes the importer leave that slot empty and show UNKNOWN PART, even for a
real game drop. The check covers every section under a weapon namespace (gd_weap_*,
dlcN_gd_weap_*, gd_weap_names_shared, gd_customweapons), grouped by folder so a whole missing category stands
out. Usage: python tools/audit/audit_missing_parts.py
"""
import json, os, re, collections, pathlib

ROOT = pathlib.Path(__file__).resolve().parents[2]
PARTSDB = pathlib.Path(os.environ.get("WILLOWTREE_PARTSDB", r"C:/path/to/WillowTree#/Data/PartsDb.txt"))  # PartsDb.txt from your WillowTree# folder
g = json.loads((ROOT / 'app/web/gearData.json').read_text(encoding='utf-8'))

known = set()
def add(src, cat, pid, p=None):
    if not src:
        return
    known.add(f'{src}.{cat}.{pid}')
    known.add(f'{src}.{pid}')
    if p and p.get('dir'):
        known.add(f"{src}.{p['dir']}.{pid}")
    for alt in (p or {}).get('alt', []):   # identical duplicate paths the importer also accepts
        known.add(f'{alt}.{pid}')

for t in g['types'].values():
    for cat, slot in t['slots'].items():
        for pid, p in slot.get('parts', {}).items():
            add(p.get('src') or t['ns'], 'ManufacturerMaterials' if cat == 'Material' else cat, pid, p)
for pid, p in g['sharedPrefixes'].items():
    add(p.get('src'), 'Prefix', pid, p)
for pid, p in g.get('sharedTitles', {}).items():
    add(p.get('src'), 'Title', pid, p)
for pid, p in g['materials'].items():
    add(p.get('src'), 'ManufacturerMaterials', pid, p)
    known.add(p.get('src', ''))  # some materials store their full path as src

WEAPON_NS = re.compile(r'^(dlc\d+_)?gd_(weap_|customweapons)')
# folders that hold weapon parts (A_Weapon / grades / firing modes are not parts)
PART_FOLDERS = re.compile(r'(Body|Grip|mag|Barrel|Sight|Stock|Action|acc|Prefix|Title|Material|UniqueParts|SMG|Pistol|Rifle|Sniper|Shotgun|Launcher|MachineGun|Repeater|Revolver)', re.I)

missing = collections.defaultdict(list)
for line in PARTSDB.read_text(encoding='utf-8', errors='replace').splitlines():
    m = re.match(r'^\[([^\]]+)\]$', line)
    if not m:
        continue
    path = m.group(1)
    segs = path.split('.')
    if len(segs) < 3 or not WEAPON_NS.match(segs[0]):
        continue
    folder = '.'.join(segs[:-1])
    if re.match(r'(CustomWeap_|GoldenChest_|ItemGrade_)', segs[-1]):
        continue  # item grades, not parts
    if 'A_Weapon' in folder or 'FiringMode' in folder or not (PART_FOLDERS.search(segs[-2]) or 'customweapons' in segs[0]):
        continue
    if path not in known:
        missing[folder].append(segs[-1])

total = sum(len(v) for v in missing.values())
print(f'{total} weapon parts in PartsDb that gearData cannot resolve, in {len(missing)} folders:\n')
for folder in sorted(missing, key=lambda f: -len(missing[f])):
    ids = missing[folder]
    print(f'{len(ids):4}  {folder}: {", ".join(ids[:8])}{" ..." if len(ids) > 8 else ""}')
