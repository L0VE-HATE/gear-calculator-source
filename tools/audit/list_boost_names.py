"""Lists every Title/Prefix in gearData.json that gives a real weapon boost (not just rarity/flavor),
using the same rule the app uses to decide which ones to offer on every weapon type.
Run in the foreground: python list_boost_names.py"""
import json, os
G = json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "app", "web", "gearData.json"), encoding="utf-8"))

# stat -> (label, good_direction, min_size). Direction +1: higher is better; -1: lower (a time / spread) is better.
MAJOR = {
    "WeaponDamage": ("Damage", +1, 0.05), "WeaponCritBonus": ("Crit", +1, 0.05),
    "WeaponFireRate": ("Fire rate", -1, 0.05), "WeaponReloadSpeed": ("Reload", -1, 0.05),
    "WeaponSpread": ("Accuracy", -1, 0.05), "WeaponPerShotAccuracyImpulse": ("Recoil", -1, 0.05),
    "WeaponClipSize": ("Magazine", +1, 0.05), "WeaponProjectilesPerShot": ("Pellets", +1, 1.0),
    "WeaponAutomaticBurstCount": ("Burst", +1, 1.0), "WeaponProjectileSpeedMultiplier": ("Projectile speed", +1, 0.05),
    "WeaponZoomEndFOV": ("Zoom", -1, 0.05),
}

def benefits(p):
    out = []
    st, fl = p.get("st") or {}, p.get("fl") or {}
    if (st.get("WeaponDamage") or 0) <= -0.10: return out   # a real damage cut makes it a tradeoff, not a boost
    for stat, (label, good, mn) in MAJOR.items():
        v = st.get(stat)
        if v is None: continue
        if stat in ("WeaponProjectilesPerShot", "WeaponAutomaticBurstCount"): v = fl.get(stat, 0)   # counts are flat adds
        if v * good >= mn: out.append(label)
    return out

def collect():
    rows = {}
    for tid, t in G["types"].items():
        for slot in ("Title", "Prefix"):
            for pid, p in t["slots"].get(slot, {}).get("parts", {}).items():
                b = benefits(p)
                if not b: continue
                key = (slot, p.get("src"), pid)
                rows.setdefault(key, {"name": p.get("name") or pid, "types": set(), "benefits": b, "st": p.get("st"), "fl": p.get("fl"), "rarity": p.get("rarity")})["types"].add(tid)
    return rows

if __name__ == "__main__":
    rows = collect()
    for slot in ("Title", "Prefix"):
        sel = sorted((k, v) for k, v in rows.items() if k[0] == slot)
        print("\n=== %s: %d boosting parts" % (slot, len(sel)))
        for (s, src, pid), v in sel:
            print("  %-28s %-45s [%s] on %s" % (v["name"], pid, ", ".join(v["benefits"]), ",".join(sorted(v["types"]))[:60]))
