"""Copy the game's own red card text onto gearData.json parts.

In the game every part can carry an AttributePresentationDefinition whose text the item card prints in red:
  NoConstraintText  - the flavor line   ("Good Touch" on Kyros' Power, "Phooon!" on Typhoon, ...)
  Description       - an ability line   ("Burst Fire", "Very high Elemental Effect chance", "Sledge's prized possession")
A part can have more than one (Nidhogg: "Death rains from above" + "Airburst Rockets") - they are stored joined by a
newline in part["desc"], in the game's order. Idempotent; run after build_hidden_data.py (independent of it).

usage: python build_card_text.py            (writes app/web/gearData.json)
       python build_card_text.py --dry      (only reports)
"""
import glob, json, os, sys
sys.path.insert(0, os.path.dirname(__file__))
from read_props import Pkg

ROOT = os.environ.get("BL1_COOKEDPC", r"C:/Program Files (x86)/Steam/steamapps/common/Borderlands/WillowGame/CookedPC")  # your Borderlands 1 CookedPC folder
GEARDATA = os.path.join(os.path.dirname(__file__), '..', '..', 'app', 'web', 'gearData.json')


def owner_key(pkg, unique_pkg, path):
    """(src, pid) of the part that owns a presentation whose export path is <owner...>.AttributePresentationDefinition."""
    owner = path.split('.')[:-1]
    if not owner: return None
    if unique_pkg: return pkg + '.' + '.'.join(owner[:-1]), owner[-1]
    if len(owner) == 2 and owner[0] == 'UniqueParts': return pkg + '.UniqueParts', owner[1]
    if len(owner) == 2: return pkg, owner[1]
    return None


def main(dry):
    files = sorted(glob.glob(ROOT + '/Packages/GameData/Weapons/gd_weap_*.upk')) + \
            glob.glob(ROOT + '/DLC/**/dlc3_gd_weap_UniqueParts.upk', recursive=True)
    texts = {}                                                     # (src, pid) -> [lines]
    for f in files:
        p = Pkg(f); pkg = os.path.basename(f)[:-4]; uniq = 'UniqueParts' in pkg
        for i, e in enumerate(p.exports):
            if p.cname(e['cls']) != 'AttributePresentationDefinition': continue
            path = p.path(i)
            if '.WeaponType_' in path: continue                    # weapon-TYPE lines are handled by build_hidden_data.py
            key = owner_key(pkg, uniq, path)
            if not key: continue
            try: props = p.props(i)
            except Exception: continue
            for k, t, x, v in props:
                if t == 'StrProperty' and k in ('NoConstraintText', 'Description') and isinstance(v, str) and v.strip():
                    texts.setdefault(key, []).append(v.strip())
    G = json.load(open(GEARDATA, encoding='utf-8'))
    by_pid = {}
    entries = []
    for tid, t in G['types'].items():
        for slot, s in t['slots'].items():
            for pid, part in s['parts'].items(): entries.append((part, pid))
    for pid, part in G.get('materials', {}).items(): entries.append((part, pid))
    for part, pid in entries: by_pid.setdefault(pid, []).append(part)
    added = fixed = same = unmatched = 0
    for (src, pid), lines in sorted(texts.items()):
        desc = '\n'.join(lines)
        hits = [x for x in by_pid.get(pid, []) if x.get('src') == src] or (by_pid.get(pid, []) if len({x.get('src') for x in by_pid.get(pid, [])}) == 1 else [])
        if not hits: unmatched += 1; print('  no gearData part for', src, pid, repr(desc)); continue
        for part in hits:
            if part.get('desc') == desc: same += 1
            else:
                print('  %s %-38s %r -> %r' % ('SET  ' if not part.get('desc') else 'FIX  ', pid, part.get('desc'), desc))
                part['desc'] = desc; added += (not part.get('desc')); fixed += 1
    print('%d already right, %d set/fixed, %d game texts with no gearData part' % (same, fixed, unmatched))
    if not dry:
        open(GEARDATA, 'w', encoding='utf-8', newline='').write(json.dumps(G, separators=(',', ':'), ensure_ascii=False))


if __name__ == '__main__':
    main('--dry' in sys.argv)
