"""Restore ordinary base-game accessories that a same-id DLC "alias" part overwrote in gearData.json.

gearData keeps ONE entry per (weapon type, slot, part id). Knoxx (DLC3) re-used two ordinary accessory ids for renamed
uniques - the game keeps them as redirectors:
    dlc3_gd_weap_UniqueParts.SMG.acc3_Shock              -> Tsunami's accessory
    dlc3_gd_weap_UniqueParts.RevolverPistol.acc5_Explosive -> Aries' healing accessory
and the alias won, so the plain Patrol SMG "Shock" and plain Revolver "Explosive" accessories were replaced by Tsunami's
(uniq, tech 12, Shock+Corrosive) and Aries' (Shock + healing Transfusion orbs). This rebuilds the two ordinary parts
from PartsDb.txt. The real uniques still exist under their own ids (acc3_Maliwan_Tsunami, acc5_Heal_AtlasAries).

Detect any others:  python fix_alias_collisions.py --check      (lists parts whose stored src differs from the base package)
Fix:                python fix_alias_collisions.py              (idempotent; run BEFORE tools/upk/build_hidden_data.py)
"""
import json, os, re, sys

PARTSDB = os.environ.get("WILLOWTREE_PARTSDB", r"C:/path/to/WillowTree#/Data/PartsDb.txt")  # PartsDb.txt from your WillowTree# folder
GEARDATA = os.path.join(os.path.dirname(__file__), '..', '..', 'app', 'web', 'gearData.json')
FIX = [('patrol_smg', 'acc', 'acc3_Shock'), ('revolver_pistol', 'acc', 'acc5_Explosive')]
ALIAS = {'AccuracyMinValue': 'MinAccuracy', 'AccuracyMaxValue': 'MaxAccuracy'}


def section(name):
    out, on = {}, False
    for line in open(PARTSDB, encoding='utf-8', errors='replace'):
        line = line.rstrip('\n')
        if line.startswith('['):
            if on: break
            on = line.strip('[]') == name; continue
        if on: out.setdefault('lines', []).append(line)
    return out.get('lines')


def main():
    G = json.load(open(GEARDATA, encoding='utf-8'))
    for tid, slot, pid in FIX:
        t = G['types'][tid]; ns = t['ns']
        lines = section('%s.%s.%s' % (ns, slot, pid))
        assert lines, 'no PartsDb section for %s.%s.%s' % (ns, slot, pid)
        kv = {}; st = {}
        for l in lines:
            m = re.match(r'(\w+)=(.*)', l)
            if m and not l.startswith('effect'): kv[m.group(1)] = m.group(2).strip('"')
            m = re.search(r'Modify (\w+) by (\S+) \((\w+)\)', l)
            if m and l.startswith('effect('): st[ALIAS.get(m.group(1), m.group(1))] = st.get(ALIAS.get(m.group(1), m.group(1)), 0) + float(m.group(2))
        part = {'name': kv['PartName'], 'pn': kv['PartName'], 'rarity': int(float(kv['Rarity'])), 'cash': float(kv['CashValueModifier']),
                'tech': float(kv['TechLevelIncrease']), 'addend': int(kv['PartNumberAddend']), 'st': st, 'src': ns, 'named': 1}
        old = t['slots'][slot]['parts'].get(pid)
        t['slots'][slot]['parts'][pid] = part
        print('%-16s %-14s was src=%s  ->  base part %s' % (tid, pid, (old or {}).get('src'), json.dumps(part)))
    open(GEARDATA, 'w', encoding='utf-8', newline='').write(json.dumps(G, separators=(',', ':'), ensure_ascii=False))


def check():
    sect = {l.strip().strip('[]') for l in open(PARTSDB, encoding='utf-8', errors='replace') if l.startswith('[')}
    G = json.load(open(GEARDATA, encoding='utf-8')); n = 0
    for tid, t in G['types'].items():
        if tid == 'shield': continue
        nss = [x for x in (t.get('ns'), t.get('partnerNs')) if x]
        for slot, s in t['slots'].items():
            for pid, p in s['parts'].items():
                if (p.get('src') or '') in nss: continue
                base = [x + '.' + slot + '.' + pid for x in nss if x + '.' + slot + '.' + pid in sect]
                if base and 'alien' not in base[0]: print(tid, slot, pid, p.get('src'), '<-', base[0]); n += 1
    print(n, 'collision(s) (Eridian Knoxx barrels are intentional and excluded)')


if __name__ == '__main__':
    check() if '--check' in sys.argv else main()
