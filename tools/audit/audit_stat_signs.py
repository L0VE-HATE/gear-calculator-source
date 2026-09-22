"""Audit: does every part's stat in gearData.json match the real PartsDb.txt effect line(s)?

Found because Thumper's mag (WeaponFireRate +2 Scale in PartsDb) was stored as -2 in gearData.json, making a
slower/bigger-damage magazine fire 3x FASTER. Compares, per part and per stat, the sum of every
`Modify <Stat> by <N> (<mode>)` line in PartsDb against gearData's part["st"][stat].

usage: python audit_stat_signs.py            (read-only; prints mismatches, opposite-sign ones flagged)
"""
import json, os, re, sys

PARTSDB = os.environ.get("WILLOWTREE_PARTSDB", r"C:/path/to/WillowTree#/Data/PartsDb.txt")  # PartsDb.txt from your WillowTree# folder
GEARDATA = os.path.join(os.path.dirname(__file__), '..', '..', 'app', 'web', 'gearData.json')
ALIAS = {'AccuracyMinValue': 'MinAccuracy', 'AccuracyMaxValue': 'MaxAccuracy', 'PlayerCriticalHitBonus': 'WeaponCritBonus'}

raw, cur = {}, None
for line in open(PARTSDB, encoding='utf-8', errors='replace'):
    line = line.rstrip('\n')
    if line.startswith('['): cur = line.strip('[]'); raw[cur] = {}
    elif cur and line.startswith('effect('):
        m = re.search(r'Modify (\w+) by (\S+) \((\w+)\)', line)
        if m and not m.group(2).startswith('FORMULA'):
            try: v = float(m.group(2))
            except ValueError: continue
            st = ALIAS.get(m.group(1), m.group(1))
            raw[cur][st] = raw[cur].get(st, 0) + v

G = json.load(open(GEARDATA, encoding='utf-8'))
FOLDER = {'Material': 'ManufacturerMaterials'}
seen, rows, checked, unmatched = set(), [], 0, 0
for tid, t in G['types'].items():
    for slot, s in t['slots'].items():
        for pid, p in s['parts'].items():
            src = p.get('src') or ''
            keys = [src + '.' + pid, src + '.' + FOLDER.get(slot, slot) + '.' + pid]
            key = next((k for k in keys if k in raw), None)
            if key is None: unmatched += 1; continue
            if key in seen: continue
            seen.add(key); checked += 1
            for stat, v in (p.get('st') or {}).items():
                r = raw[key].get(stat)
                if r is None or abs(r - v) < 1e-6: continue
                rows.append((key, stat, r, v, 'OPPOSITE SIGN' if abs(r + v) < 1e-6 else 'different'))
print('checked %d parts against PartsDb (%d gearData parts had no PartsDb section)' % (checked, unmatched))
for r in sorted(rows, key=lambda x: (x[4], x[0])): print('  %-14s %-70s %-30s PartsDb=%-8s gearData=%s' % (r[4], r[0], r[1], r[2], r[3]))
print(len(rows), 'mismatched stat values')
