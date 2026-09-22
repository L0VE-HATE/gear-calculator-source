"""Audit every gd_weap_*.upk for the two "hidden" things PartsDb.txt does not show on a part:
  1. CustomFiringModeDefinition  - the part swaps the weapon's firing mode (homing, ricochet, wave, ...)
  2. PrefixList                  - the name-prefix the part brings along; if that prefix has stat effects in
                                   PartsDb.txt (e.g. Prefix_Barrel3_Twisted = +50% damage, +50% clip) they are
                                   a hidden bonus of picking the part.
usage: python scan_hidden.py  > out.txt      (needs read_props.py next to it; uncompressed packages only)
"""
import glob, os, re, sys
sys.path.insert(0, os.path.dirname(__file__))
from read_props import Pkg

ROOT = os.environ.get("BL1_COOKEDPC", r"C:/Program Files (x86)/Steam/steamapps/common/Borderlands/WillowGame/CookedPC")  # your Borderlands 1 CookedPC folder
PARTSDB = os.environ.get("WILLOWTREE_PARTSDB", r"C:/path/to/WillowTree#/Data/PartsDb.txt")  # PartsDb.txt from your WillowTree# folder

# token -> effect strings (any section whose last path segment is the token)
eff, cur = {}, None
for l in open(PARTSDB, encoding='utf-8', errors='replace'):
    l = l.rstrip('\n')
    if l.startswith('['): cur = l.strip('[]').split('.')[-1]; eff.setdefault(cur, [])
    elif cur and l.startswith('effect('):
        eff[cur].append(re.sub(r'Modify (\w+) by (\S+) \((\w+)\)', r'\1 \2 \3', l.split('="')[1].rstrip('"')))

files = sorted(glob.glob(ROOT + '/Packages/GameData/Weapons/gd_weap_*.upk') +
               glob.glob(ROOT + '/DLC/**/gd_weap_*.upk', recursive=True) +
               glob.glob(ROOT + '/DLC/**/*UniqueParts*.upk', recursive=True))
for f in files:
    try: p = Pkg(f)
    except Exception as ex: print('SKIP', os.path.basename(f), ex); continue
    rows = []
    for i, e in enumerate(p.exports):
        if p.cname(e['cls']) != 'WeaponPartDefinition': continue
        try: d = {k: v for k, t, x, v in p.props(i)}
        except Exception: continue
        fm = d.get('CustomFiringModeDefinition')
        pre = [x.split(':')[-1] for x in d.get('PrefixList', []) if isinstance(d.get('PrefixList'), list)]
        pre_eff = {x: eff.get(x) for x in pre if eff.get(x)}
        if fm or pre_eff:
            rows.append('  %-34s fm=%-34s prefix=%s' % (p.path(i), str(fm).replace('FiringModeDefinition:', '') if fm else '-',
                        '; '.join('%s [%s]' % (k, ', '.join(v)) for k, v in pre_eff.items()) or '-'))
    if rows: print('##', os.path.basename(f)); print('\n'.join(rows))
