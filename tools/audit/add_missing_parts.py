"""Add the weapon parts gearData.json was missing, so real items stop importing as UNKNOWN PART.

Two kinds of fix, both read from WillowTree's PartsDb.txt (never hand-typed):

1. Whole groups that were never imported (every entry is a real part that real items use):
     gd_weap_names_shared.Prefix_Tech.*          element prefixes   (Caustic, Combustion, Detonating ...)
     gd_weap_names_shared.Prefix_Starter.*       starting-gun prefixes (Rusty, Busted, Defective ...)
     gd_weap_names_shared.Title_Tech.*           element titles     (Corrosion, Inferno, Storm ...)
     gd_weap_shared_materialparts.CustomMaterials.*  Gun Pack + BSG golden-chest gun materials
   Prefixes go into sharedPrefixes, titles into a new sharedTitles pool, materials into materials.
   Each keeps its real folder in `dir` so the exported code writes the exact game path back.

2. Duplicate paths: PartsDb lists some parts under two paths (Knoxx's Gold's title in both
   dlc3_ and dlc4_gd_weap_UniqueParts.Title, BSG titles in gd_customweapons.BSG_Weapons and in
   the weapon type's Title folder ...). A missing path is linked to an existing part ONLY when its
   PartsDb section is line-for-line identical to that part's own section; its folder goes into
   the part's `alt` list, which the importer accepts. When a saved build in index.html uses the
   missing path (a real item export), that path becomes the part's primary src instead, so the
   app writes the path the game itself uses.

Not added on purpose (not player gear, or no evidence any real item uses them): the 23
gd_weap_shared_materialparts.Material.* camo materials, *_test_*, *_toon, gd_weap_scorpio
(Roland's turret), and paths whose PartsDb data differs from the part of the same id
(e.g. the Knoxx redirectors dlc3 SMG.acc3_Shock / RevolverPistol.acc5_Explosive, see
fix_alias_collisions.py). Re-running is safe (idempotent). Run order: after
fix_alias_collisions.py, before tools/upk/build_hidden_data.py.
Usage: python tools/audit/add_missing_parts.py
"""
import json, os, re, pathlib, runpy

ROOT = pathlib.Path(__file__).resolve().parents[2]
GEARDATA = ROOT / 'app/web/gearData.json'
PARTSDB = pathlib.Path(os.environ.get("WILLOWTREE_PARTSDB", r"C:/path/to/WillowTree#/Data/PartsDb.txt"))  # PartsDb.txt from your WillowTree# folder
ALIAS = {'AccuracyMinValue': 'MinAccuracy', 'AccuracyMaxValue': 'MaxAccuracy'}

sections = {}
cur = None
for line in PARTSDB.read_text(encoding='utf-8', errors='replace').splitlines():
    if line.startswith('[') and line.endswith(']'):
        cur = line[1:-1]; sections[cur] = []
    elif cur is not None and line.strip():
        sections[cur].append(line)


def to_part(lines, src, dir_):
    kv, st, fl = {}, {}, {}
    for l in lines:
        m = re.search(r'Modify (\w+) by (\S+) \((\w+)\)', l)
        if l.startswith('effect(') and m:
            stat = ALIAS.get(m.group(1), m.group(1)); v = float(m.group(2))
            st[stat] = st.get(stat, 0) + v
            if m.group(3) in ('PreAdd', 'PostAdd'):
                fl[stat] = fl.get(stat, 0) + v
            continue
        m = re.match(r'(\w+)=(.*)', l)
        if m:
            kv[m.group(1)] = m.group(2).strip('"')
    p = {'rarity': int(float(kv.get('Rarity', 0))), 'cash': float(kv.get('CashValueModifier', 1)), 'src': src, 'dir': dir_}
    if 'PartName' in kv:
        p['name'] = p['pn'] = kv['PartName']
    if 'Priority' in kv:
        p['prio'] = float(kv['Priority'])
    if 'TechLevelIncrease' in kv:
        p['tech'] = float(kv['TechLevelIncrease'])
    if st:
        p['st'] = st
    if fl:
        p['fl'] = fl
    return p


G = json.loads(GEARDATA.read_text(encoding='utf-8'))
G.setdefault('sharedTitles', {})
GROUPS = [('gd_weap_names_shared', 'Prefix_Tech', G['sharedPrefixes']),
          ('gd_weap_names_shared', 'Prefix_Starter', G['sharedPrefixes']),
          ('gd_weap_names_shared', 'Title_Tech', G['sharedTitles']),
          ('gd_weap_shared_materialparts', 'CustomMaterials', G['materials'])]
added = 0
for src, dir_, pool in GROUPS:
    folder = src + '.' + dir_ + '.'
    for path, lines in sections.items():
        if not path.startswith(folder):
            continue
        pid = path[len(folder):]
        if pid in pool and pool[pid].get('dir') != dir_:
            raise SystemExit(f'id clash: {pid} already in the pool from {pool[pid].get("src")} - resolve by hand')
        pool[pid] = to_part(lines, src, dir_); added += 1
print(f'added/refreshed {added} parts from 4 missing groups')

# ---- duplicate paths ----
real_lines = set()
html = (ROOT / 'app/web/index.html').read_text(encoding='utf-8')
for m in re.finditer(r'code:"([^"]+)"', html):
    real_lines.update(m.group(1).split('\\n'))
for m in re.finditer(r'`([^`]+)`', html):
    real_lines.update(l.strip() for l in m.group(1).splitlines())


def own_path(p, cat, pid):
    if p.get('dir'):
        return f"{p['src']}.{p['dir']}.{pid}"
    if p.get('uniq'):
        return f"{p['src']}.{pid}"
    return f"{p['src']}.{'ManufacturerMaterials' if cat == 'Material' else cat}.{pid}"


candidates = {}   # pid -> [(part, own full path)]
for tid, t in G['types'].items():
    for cat, slot in t['slots'].items():
        for pid, p in slot.get('parts', {}).items():
            candidates.setdefault(pid, []).append((p, cat))
for pid, p in G['sharedPrefixes'].items():
    candidates.setdefault(pid, []).append((p, 'Prefix'))
for pid, p in G['sharedTitles'].items():
    candidates.setdefault(pid, []).append((p, 'Title'))
for pid, p in G['materials'].items():
    candidates.setdefault(pid, []).append((p, 'Material'))

missing = runpy.run_path(str(ROOT / 'tools/audit/audit_missing_parts.py'), run_name='audit')['missing']
linked, promoted = 0, 0
NOT_PLAYER_GEAR = re.compile(r'_test_|_toon|gd_weap_scorpio')   # dev test guns, toon test gun, Roland's turret
for folder, ids in missing.items():
    if NOT_PLAYER_GEAR.search(folder):
        continue
    for pid in ids:
        path = folder + '.' + pid
        mine = sections.get(path)
        for p, cat in candidates.get(pid, []):
            if own_path(p, cat, pid) == path:
                continue   # this is the part itself (e.g. one of the groups just added above)
            theirs = sections.get(own_path(p, cat, pid))
            if theirs is None or theirs != mine:
                continue
            if path in real_lines and p.get('uniq'):
                old = p['src']; p['src'] = folder
                p['alt'] = sorted(set(p.get('alt', [])) - {folder} | {old}); promoted += 1
                print(f'  primary  {path}  (real items use it; old {old} kept as alt)')
            elif folder not in p.get('alt', []) and folder != p.get('src'):
                p.setdefault('alt', []).append(folder); linked += 1
print(f'linked {linked} identical duplicate paths, promoted {promoted} to primary')

GEARDATA.write_text(json.dumps(G, separators=(',', ':'), ensure_ascii=False), encoding='utf-8', newline='')
