import os
import json
from collections import defaultdict

with open(os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'app', 'web', 'gearData.json')), encoding="utf-8") as f:
    D = json.load(f)

# Every Title/Prefix across every weapon type, plus the global sharedPrefixes pool.
rows = []  # (tid, slot, pid, part)
for tid, t in D["types"].items():
    for slot in ("Title", "Prefix"):
        for pid, p in t["slots"].get(slot, {}).get("parts", {}).items():
            rows.append((tid, slot, pid, p))
for pid, p in D.get("sharedPrefixes", {}).items():
    rows.append(("(shared)", "Prefix", pid, p))

# Flat (fl) contributions are the ones that benefit most from the duplicate-slot trick - a
# Title/Prefix normally only occupies its own one slot, so a flat bonus there is "free" compared
# to a functional part, and duplicating it into both the Prefix AND Title line doubles it exactly
# (confirmed live: Anarchy's flat WeaponProjectilesPerShot, barrel3_Twisted's Scale damage bonus).
flat_hits = defaultdict(list)
for tid, slot, pid, p in rows:
    for stat, val in (p.get("fl") or {}).items():
        if val:
            flat_hits[stat].append((val, tid, slot, pid, p.get("name") or pid))

print("=" * 78)
print("FLAT (fl) stat contributions on any Title/Prefix - these are the ones that")
print("stack cleanly and predictably via the duplicate-slot trick (confirmed mechanic)")
print("=" * 78)
for stat in sorted(flat_hits, key=lambda s: -max(abs(v[0]) for v in flat_hits[s])):
    entries = sorted(flat_hits[stat], key=lambda x: -x[0])
    print(f"\n-- {stat} --")
    for val, tid, slot, pid, name in entries:
        sign = "+" if val > 0 else ""
        print(f"   {sign}{val:<6} {tid:22s} {slot:7s} {pid:35s} ({name})")

print()
print("=" * 78)
print("Notable SCALE (st) contributions with |value| >= 1.0 (100%+) on a Title/Prefix -")
print("still stack when duplicated (each adds to the same running ratio() sum), just")
print("via the normal (1+bonuses)/(1+penalties) rule rather than a flat doubling")
print("=" * 78)
scale_hits = defaultdict(list)
for tid, slot, pid, p in rows:
    for stat, val in (p.get("st") or {}).items():
        if abs(val) >= 1.0:
            scale_hits[stat].append((val, tid, slot, pid, p.get("name") or pid))
for stat in sorted(scale_hits, key=lambda s: -max(abs(v[0]) for v in scale_hits[s])):
    entries = sorted(scale_hits[stat], key=lambda x: -x[0])
    print(f"\n-- {stat} --")
    for val, tid, slot, pid, name in entries[:10]:
        sign = "+" if val > 0 else ""
        print(f"   {sign}{val:<6} {tid:22s} {slot:7s} {pid:35s} ({name})")
