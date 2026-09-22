import os
"""
Data-integrity audit: find places where a shared naming pattern (a common prefix/word) masks
real, functionally-important differences underneath - the same category of bug as
Material_Anshin_1 (looks like every other "Material_<Manufacturer>_<tier>" entry, is actually
dead/non-functional data) and the Item Grade mismatch (looks like just another "gd_itemgrades.*"
string, actually determines whether a unique-part build loads at all).

Run from anywhere; paths are absolute.
"""
import json, re
from collections import defaultdict

with open(os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'app', 'web', 'gearData.json')), encoding="utf-8") as f:
    D = json.load(f)
with open(os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'app', 'web', 'index.html')), encoding="utf-8") as f:
    HTML = f.read()

print("=" * 70)
print("SECTION 1: weapon materials - full real-usage audit")
print("=" * 70)

# Pull every material pid referenced anywhere in SAVE_BUILDS/MY_BUILDS code strings.
m = re.search(r'const SAVE_BUILDS\s*=\s*\[\n(.*?)\n\];', HTML, re.DOTALL)
save_block = m.group(1)
save_entries = re.findall(r'\{label:"([^"]+)".*?code:"((?:[^"\\]|\\.)*)"\}', save_block)

m2 = re.search(r'const MY_BUILDS = \[(.*?)\n\];', HTML, re.DOTALL)
my_block = m2.group(1) if m2 else ""
my_codes = re.findall(r'`([^`]*)`', my_block)

used_material_pids = set()
for label, code in save_entries:
    lines = code.split('\\n')
    if len(lines) >= 12:
        used_material_pids.add(lines[11].split('.')[-1])
for code in my_codes:
    lines = [l for l in code.split('\n') if l.strip()]
    if len(lines) >= 12:
        used_material_pids.add(lines[11].split('.')[-1])

print(f"Distinct material pids seen across {len(save_entries)} SAVE_BUILDS + {len(my_codes)} MY_BUILDS: {len(used_material_pids)}")

unused = []
for pid, p in D["materials"].items():
    if pid not in used_material_pids:
        unused.append((pid, p))

print(f"\nMaterials NEVER used by any real/verified build ({len(unused)} of {len(D['materials'])}):")
for pid, p in sorted(unused):
    print(f"  {pid:35s} src={p.get('src','?'):40s} rarity={p.get('rarity')} uniq={p.get('uniq')}")

print()
print("=" * 70)
print("SECTION 2: Item Grade coverage / parse-ability")
print("=" * 70)


def grade_parse(key):
    mm = re.match(r'^(?:dlc\d+_)?gd_(itemgrades|customweapons|customitems)\.([^.]+)\.(.+)$', key)
    if mm:
        return mm.group(1), mm.group(2), mm.group(3)
    return '', '', key


unparsed = [k for k in D["grades"] if grade_parse(k)[0] == '']
print(f"G.grades keys that DON'T match the expected gd_<kind>.<ns>.<token> shape ({len(unparsed)} of {len(D['grades'])}):")
for k in unparsed:
    print("  ", k)

print()
missing_std = []
for tid, t in D["types"].items():
    if tid == "shield":
        continue
    key = t["itemGradeNs"] + "." + t["itemGradeToken"]
    if key not in D["grades"]:
        missing_std.append((tid, key))
print(f"Weapon types whose OWN standard Item Grade key is missing from G.grades ({len(missing_std)}):")
for tid, key in missing_std:
    print(f"  {tid}: {key}")

print()
print("=" * 70)
print("SECTION 3: Item-Grade-vs-UniqueParts rule - exception search")
print("=" * 70)
print("(confirms whether ANY real save weapon breaks the just-discovered rule)")

exceptions = []
ok_count = 0
for label, code in save_entries:
    lines = code.split('\\n')
    if len(lines) < 14:
        continue
    grade = lines[0]
    parts = lines[3:14]
    has_uniqueparts = any('UniqueParts' in p for p in parts if p != 'None')
    grade_is_custom = 'customweapons' in grade
    if has_uniqueparts:
        if grade_is_custom:
            ok_count += 1
        else:
            exceptions.append((label, grade, [p for p in parts if 'UniqueParts' in p]))

print(f"Real weapons using ANY UniqueParts part: {ok_count + len(exceptions)}")
print(f"  ...with a matching customweapons grade: {ok_count}")
print(f"  ...WITHOUT one (rule exceptions): {len(exceptions)}")
for x in exceptions:
    print("  EXCEPTION:", x)

print()
print("=" * 70)
print("SECTION 4: 'uniq' field meaning collision check")
print("=" * 70)
save_uniq_true_low_rarity = [(l, c.split('\\n')[3:14]) for l, c in save_entries]
# just report the raw shape difference between p.uniq (part-level) and b.uniq (armory-row-level)
sample = re.search(r'\{label:"([^"]+)"[^}]*uniq:(true|false)[^}]*rarity:(\d+)', save_block)
print("Sample SAVE_BUILDS entry fields (label/uniq/rarity):")
for mobj in list(re.finditer(r'\{label:"([^"]+)"[^,]*,\s*tid:"[^"]*",\s*tlabel:"[^"]*",\s*manu:"[^"]*",\s*level:\d+,\s*quality:\d+,\s*rarity:(\d+),\s*uniq:(true|false)', save_block))[:10]:
    print(f"  {mobj.group(1):20s} rarity={mobj.group(2):4s} uniq(row-level)={mobj.group(3)}")
print("(row-level 'uniq' distinguishes Pearlescent from Legendary tier in saveArmoryRowHTML -")
print(" a completely different meaning from a PART's own 'uniq' flag, which means 'sourced from")
print(" WillowTree's UniqueParts pool'. Same word, two unrelated meanings, in the same file.)")
