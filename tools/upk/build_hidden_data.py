"""Write the "hidden" weapon data read from the game's own .upk files into app/web/gearData.json.

What it adds (all read from the real packages via read_props.py, nothing typed in by hand except the
short display wording for each firing mode in FM_TEXT below, which is checked against the firing-mode
data - see the notes there):
  part["fx"]            list of short effect lines for a part whose CustomFiringModeDefinition swaps how the
                        gun fires (Ball Blaster = homing, Wave Blaster, Twisted barrel, ...)
  part["pfx"]           pid of the name-Prefix the part brings along (its PrefixList) when that prefix has
                        real stat effects, e.g. barrel3_Twisted -> Prefix_Barrel3_Twisted (+50% dmg/clip)
  type["flavor"]        the red card line the weapon TYPE itself carries ("Pew Pew Pew!" on the Eridian Blaster)
  type["barrelPool"]    the barrels the game's own part list lets that weapon type roll (Eridian types)

Idempotent: strips its own earlier output first. Run from anywhere:  python build_hidden_data.py
"""
import glob, json, os, re, sys
sys.path.insert(0, os.path.dirname(__file__))
from read_props import Pkg, deep

ROOT = os.environ.get("BL1_COOKEDPC", r"C:/Program Files (x86)/Steam/steamapps/common/Borderlands/WillowGame/CookedPC")  # your Borderlands 1 CookedPC folder
GEARDATA = os.path.join(os.path.dirname(__file__), '..', '..', 'app', 'web', 'gearData.json')

# Display wording per firing mode. Every line is backed by the firing-mode / projectile data:
#   PROJ_Tracking_Ball   -> its projectile PlasmaSphere_Small_Tracking has ProjectileBehavior_Home (HTARGET_NearestFoe)
#   FM_WaveBlaster       -> DmgType_Shock_Passive, NumRicochets 2, WaveFreq/WaveAmp set (oscillating)
#   FM_Twisted           -> NumRicochets 2, Speed 4000 (default bullet 13000), WaveFreq/Amp/Phase set
#   FM_Launcher_MegaCannon -> EWWFT_Rocket projectile PlasmaSphere_MegaCannon, Speed 1200
#   Fireball/Firebomb/Flaregun -> DmgType_Incendiary_Passive, Acceleration z=-300 + AirFriction (arcing lob)
#   Glob/Splat/Rolling/Stampeding -> DmgType_Corrosive_Passive, same arc; Splat_Parent has Splat_Child chain
#                            objects, Rolling = Spatter_ParentShortChain, Stampeding = Spatter_ParentLongChain
FM_TEXT = {
    'PROJ_Tracking_Ball': 'Homing shots - they track the nearest enemy',
    'FM_WaveBlaster': 'Shock shots in a wave pattern - ricochet twice',
    'FM_Twisted': 'Corkscrew shots that ricochet twice (slower bullets)',
    # Pearlescent Stalker barrel (dlc3 MachinePistol.barrel4_VladofStalker): NumRicochets 4, Speed 7500
    'FM_Stalker': 'Bullets ricochet up to 4 times',
    'FM_Launcher_MegaCannon': 'One big, slow plasma sphere per shot',
    'Proj_Rifle_Fireball': 'Lobbed fireballs - arcing, incendiary',
    'Proj_Rifle_Firebomb': 'Lobbed fire bombs - arcing, incendiary',
    'Proj_Rifle_Flaregun': 'Lobbed flares - arcing, incendiary',
    # Eridian Rifle barrel (the Knoxx copy of barrel3_Rifle reuses the Thunder Storm bolt): DmgType_Shock_Impact,
    # NumRicochets 1, bPenetratePawn True
    'Proj_Shotgun_Thunder_Storm': 'Shock shots that ricochet once and pierce enemies',
    # ---- named uniques + launcher barrels (profiled with describe_fm.py) ----
    # rocket_mini / FM_BoomStick_rocket / FM_grenade_mini: FireType EWWFT_Rocket + projectile with Behavior_Explode
    'rocket_mini': 'Fires small explosive rockets instead of bullets',
    'FM_BoomStick_rocket': 'Fires small explosive rockets instead of bullets',
    'FM_grenade_mini': 'Fires small explosive grenades instead of bullets',
    # FM_TKsWave_Bullets: NumRicochets 2, WaveFreq set. FM_MadJack: DmgType_Explosive_NormalImpact, NumRicochets 2, WaveFreq
    # set. bullet_Typhoon: two firing modes (NumRicochets 1 and 2, the 2nd with WaveFreq), picked at random from a pattern.
    # SandS_CruxBullet: DmgType_Explosive_NormalImpact.
    'FM_TKsWave_Bullets': 'Wave-pattern bullets that ricochet twice',
    'FM_MadJack': 'Explosive-impact bullets in a wave pattern - ricochet twice',
    'bullet_Typhoon': 'Bullets ricochet once or twice, some in a wave pattern',
    'SandS_CruxBullet': 'Explosive-impact bullets',
    # Grenade_Rebounding: ProjectileBehavior_Bounce. Grenade_Sticky: ProjectileBehavior_Attach. Rainmaker: Bounce +
    # Behavior_SpawnProjectile.
    'Grenade_Rebounding': 'Bounces off surfaces before it explodes',
    'Grenade_Sticky': 'Sticks to what it hits, then explodes',
    'Grenade_SandS_Rainmaker': 'Bounces, and spawns extra projectiles',
    # rocket_Nidhogg: Behavior_SpawnProjectile NumProjectiles 4 (rocket_mini, random downwards) after a 1.0s timer.
    # rocket_Mongol: spawns rocket_mini after 0.3s/0.2s timers. rocket_Rhino: spawns Rhino_Exploder after timers.
    'rocket_Nidhogg': 'Rocket releases 4 mini rockets after 1 second',
    'rocket_Mongol': 'Rocket spawns mini rockets in flight',
    'rocket_Rhino': 'Rocket spawns an extra projectile in flight',
    'FM_Rifle_GlobGun': 'Lobbed corrosive glob - arcing',
    'FM_Rifle_SplatGun': 'Lobbed corrosive glob that splits into bouncing globs',
    'FM_Rifle_RollingSplatterGun': 'Lobbed corrosive glob - short chain of bouncing globs',
    'FM_Rifle_StampedingSplatterGun': 'Lobbed corrosive glob - long chain of bouncing globs',
}
# Mega Cannon is a named item on the Cannon type (gd_customweapons...CustomWeap_EridanCannon_MegaCannon):
# its barrel isn't in the type's random-drop part list but it is a real Cannon build.
EXTRA_POOL = {'WeaponType_Eridan_Cannon': ['barrel5_MegaCannon']}


def weighted_parts(p, idx):
    """pids inside a WeaponPartListDefinition's WeightedParts array (array of tagged-property structs)."""
    import struct
    b, e = p.b, p.exports[idx]
    o, end, out = e['off'] + 4, e['off'] + e['size'], []
    while o + 8 <= end:
        ni, _ = struct.unpack_from('<ii', b, o); o += 8
        nm = p.names[ni]
        if nm == 'None': break
        ti, _, size, _ai = struct.unpack_from('<iiii', b, o); o += 16
        if p.names[ti] == 'StructProperty': o += 8
        if nm == 'WeightedParts':
            n = struct.unpack_from('<i', b, o)[0]; q = o + 4
            for _ in range(n):
                while True:                                  # one struct = tagged props until None
                    ni2, _ = struct.unpack_from('<ii', b, q); q += 8
                    nm2 = p.names[ni2]
                    if nm2 == 'None': break
                    ti2, _, sz2, _ = struct.unpack_from('<iiii', b, q); q += 16
                    if p.names[ti2] == 'StructProperty': q += 8
                    if p.names[ti2] == 'BoolProperty': q += 4
                    if nm2 == 'Part': out.append(p.ref(struct.unpack_from('<i', b, q)[0]).split(':')[-1])
                    q += sz2
            return out
        o += size
    return out


# ---------------------------------------------------------------------------------------------------------------
# Accessory "tech" bullets. Every element accessory - and every named one (Firehawk, Kyros' Power, Aries, Chimera,
# Tsunami, ...) - lists TechAbilities: {RequiredTechLevel 6/9/12/15, ChanceOfHappening, TechFire = a firing mode}.
# 6/9/12/15 are exactly the card's tech tiers 1-4 (techTier() in index.html). The ELEMENT of an accessory is the
# damage type of those bullets, NOT its PartName: Firehawk's PartName is "Firehawk", Kyros' Power's is "Explosive"
# (its bullets really are Explosive and also release healing Transfusion orbs), Tsunami's is "Shock" (it procs
# Shock AND Corrosive).
# ---------------------------------------------------------------------------------------------------------------
ELEM_WORDS = ('Incendiary', 'Corrosive', 'Shock', 'Explosive')
TIER = {6: 1, 9: 2, 12: 3, 15: 4}
# A part object with none of these has no gameplay effect at all (Eridian accessories, sights, most grips/bodies): it only
# changes the model (and maybe the name). PartNumberAddend/PrefixList/TitleList only feed the weapon's NAME, so they are allowed.
EFFECT_KEYS = {'WeaponAttributeEffects', 'ExternalAttributeEffects', 'ZoomWeaponAttributeEffects', 'ZoomExternalAttributeEffects',
               'TechAbilities', 'TechLevelIncrease', 'CustomFiringModeDefinition', 'CustomDamageTypeDefinition', 'WeaponCardAttributes'}
STANDARD_BULLETS = {'IncendiaryBullet', 'CorrosiveBullet', 'ShockBullet', 'ExplosiveBullet'}


def elem_of(text):
    t = (text or '').lower()
    for w in ELEM_WORDS:
        if w.lower() in t: return w
    return None


def fm_info(p, ref_idx, ref_name):
    """What one TechFire firing mode does: its element, whether it explodes (and how big), how many healing
    Transfusion projectiles it spawns, ricochets."""
    info = {'name': ref_name, 'elem': elem_of(ref_name), 'scale': None, 'explodes': False, 'heal': None, 'ric': None}
    if ref_idx and ref_idx > 0:                                   # defined in this package: read it
        j = ref_idx - 1; d = deep(p, j)
        info['name'] = p.exports[j]['name']
        info['elem'] = elem_of(str(d.get('DamageTypeDefinition', '')).split(':')[-1]) or info['elem']
        info['ric'] = d.get('NumRicochets')
        for k, x in enumerate(p.exports):
            if x['outer'] != ref_idx: continue                     # its own nested behaviors only
            c = p.cname(x['cls']); dd = deep(p, k)
            if c == 'Behavior_Explode':
                df = dd.get('DamageFormula'); info['explodes'] = True
                info['scale'] = df.get('BaseValueScaleConstant', 1.0) if isinstance(df, dict) else 1.0
            if c == 'Behavior_SpawnProjectile' and 'Transfusion' in str(dd.get('ProjectileDefinition', '')):
                info['heal'] = max(info['heal'] or 0, dd.get('NumProjectiles', 1))
    return info


def accessory_effects(p, d):
    """(elements, effect lines) for a part whose deep() properties d carry TechAbilities."""
    abil = []
    for ta in d.get('TechAbilities') or []:
        if not isinstance(ta, dict): continue
        ch = (ta.get('ChanceOfHappening') or {}).get('BaseValueConstant')
        abil.append((TIER.get(ta.get('RequiredTechLevel')), ch, fm_info(p, ta.get('TechFire#idx'), str(ta.get('TechFire', '')).split(':')[-1])))
    elems = []
    for _, _, i in abil:
        if i['elem'] and i['elem'] not in elems: elems.append(i['elem'])
    if not elems:                       # no tech bullets that name an element (rocket launcher accessories, Hammer's imported bullet)
        e = elem_of(str(d.get('CustomDamageTypeDefinition', '')).split(':')[-1])
        if e: elems = [e]
    if not abil: return elems, []
    if all(i['name'] in STANDARD_BULLETS for _, _, i in abil): return elems, []   # ordinary element accessory: the icon + tier says it all
    lines, base_elem = [], abil[0][2]['elem']

    heals = [(t, ch, i['heal']) for t, ch, i in abil if i['heal']]
    if heals:
        if all(ch == 100 for _, ch, _ in heals):
            lines.append('Every hit releases healing Transfusion orbs: %s at tech tier %s' %
                         (' / '.join(str(h) for _, _, h in heals), ' / '.join(str(t) for t, _, _ in heals)))
        else:
            lines.append('Hits release healing Transfusion orbs: %d per hit, more at higher tech tiers (%s)' %
                         (heals[0][2], ', '.join('tier %d: %g%% chance of %d' % (t, ch, h) for t, ch, h in heals[1:])))

    groups = {}                                                    # label -> {tier: chance}
    for t, ch, i in abil[1:]:
        if i['heal'] or ch is None or ch >= 100 or t is None: continue
        if i['elem'] and i['elem'] != base_elem: label = '%s bullets' % i['elem']
        elif i['explodes'] and i['elem']:
            label = 'Exploding bullets' if i['elem'] == 'Explosive' else '%s bullets that explode' % i['elem']
            if i['scale'] not in (None, 1.0): label += ' (%gx damage)' % i['scale']
        else: continue
        groups.setdefault(label, {})[t] = ch
    merged = {}
    for label, tiers in groups.items(): merged.setdefault(tuple(sorted(tiers.items())), []).append(label)
    for tiers, labels in merged.items():
        lines.append('%s: %s' % (' / '.join(sorted(labels)).replace(' bullets / ', ' / '), ' / '.join('%g%% (tier %d)' % (ch, t) for t, ch in tiers)))
    ric = abil[0][2]['ric']
    if ric: lines.append('Bullets ricochet %s' % ('once' if ric == 1 else '%d times' % ric))
    return elems, lines


def main():
    G = json.load(open(GEARDATA, encoding='utf-8'))
    # strip our own earlier output so the script can be re-run
    for t in G['types'].values():
        t.pop('flavor', None); t.pop('barrelPool', None); t.pop('partPools', None)
        for s in t['slots'].values():
            for part in s['parts'].values(): part.pop('fx', None); part.pop('pfx', None); part.pop('elem', None); part.pop('cosmetic', None)

    # ---- per-part: firing-mode swaps + brought-along prefixes, from every weapon package ----
    # gearData's part["src"] is the package for a normal part ("gd_weap_patrol_smg") but the package PLUS the
    # folder path for a named/unique one ("dlc3_gd_weap_UniqueParts.EridanRifle.ElementalRifle"); build the
    # same key here so both kinds match.
    files = sorted(glob.glob(ROOT + '/Packages/GameData/Weapons/gd_weap_*.upk')) + \
            glob.glob(ROOT + '/DLC/**/dlc3_gd_weap_UniqueParts.upk', recursive=True)
    fm_by_pid = {}                                    # (src, pid) -> firing mode name
    pre_by_pid = {}                                   # (src, pid) -> [prefix tokens]
    plain_by_key = {}                                 # (src, pid) -> True when the game object carries no effect keys
    tech_by_key = {}                                  # (src, pid) -> (elements, effect lines) from TechAbilities
    alias_of = {}                                     # (src, old pid) -> (src, real pid): the game's ObjectRedirectors
    import struct
    for f in files:
        p = Pkg(f); pkg = os.path.basename(f)[:-4]; unique_pkg = 'UniqueParts' in pkg

        def src_of(path):
            if unique_pkg: return pkg + '.' + '.'.join(path[:-1])
            if len(path) == 2 and path[0] == 'UniqueParts': return pkg + '.UniqueParts'   # a base-game named unique (Carnage, Mad Jack, TK's Wave...)
            if len(path) == 2: return pkg                                                   # plain <Folder>.<pid> part
            return None

        for i, e in enumerate(p.exports):
            if p.cname(e['cls']) == 'ObjectRedirector' and e['size'] >= 16:
                dest = struct.unpack_from('<i', p.b, e['off'] + e['size'] - 4)[0]      # last field = the object it now points to
                if dest > 0 and p.cname(p.exports[dest - 1]['cls']) == 'WeaponPartDefinition':
                    a, b = p.path(i).split('.'), p.path(dest - 1).split('.')
                    if src_of(a) and src_of(b): alias_of[(src_of(a), a[-1])] = (src_of(b), b[-1])
            if p.cname(e['cls']) != 'WeaponPartDefinition': continue
            path = p.path(i).split('.')
            src = src_of(path)
            if src is None: continue
            d = {k: v for k, t, x, v in p.props(i)}
            fm = d.get('CustomFiringModeDefinition')
            if fm: fm_by_pid[(src, path[-1])] = str(fm).split(':')[-1]
            plain_by_key[(src, path[-1])] = not (EFFECT_KEYS & set(d))
            pl = d.get('PrefixList')
            if isinstance(pl, list) and pl: pre_by_pid[(src, path[-1])] = [x.split(':')[-1] for x in pl]
            if 'TechAbilities' in d or ('CustomDamageTypeDefinition' in d and re.search(r'(^|_)acc\d', path[-1])):
                el, ln = accessory_effects(p, deep(p, i))
                if el or ln: tech_by_key[(src, path[-1])] = (el, ln)

    nfx = npfx = 0
    for tid, t in G['types'].items():
        if tid == 'shield': continue
        for slot, s in t['slots'].items():
            for pid, part in s['parts'].items():
                key = (part.get('src'), pid)
                fm = fm_by_pid.get(key)
                if fm in FM_TEXT: part['fx'] = [FM_TEXT[fm]]; nfx += 1
                if fm in FM_TEXT: part.pop('cosmetic', None)
                if plain_by_key.get(key) and slot != 'Material' and not part.get('rarity') and not (part.get('st') or part.get('fl') or part.get('tech') or part.get('desc')):
                    part['cosmetic'] = 1
                tk = tech_by_key.get(key)
                if tk:
                    if tk[0]: part['elem'] = list(tk[0])
                    part.pop('cosmetic', None)
                    lines = [l for l in tk[1] if not (l.startswith('Bullets ricochet') and 'fx' in part)]   # firing-mode label already says it
                    if lines: part['fx'] = part.get('fx', []) + lines; nfx += 1
                if slot == 'Material': continue        # generic materials bring the -13% "QualityLow" prefixes: not a bonus
                for pre in pre_by_pid.get(key, []):
                    q = t['slots'].get('Prefix', {}).get('parts', {}).get(pre)
                    if q and q.get('st') and not pre.startswith('Prefix_QualityLow'):
                        part['pfx'] = pre; npfx += 1; break

    # The game keeps OLD part names alive as ObjectRedirectors (barrel4_Stalker -> barrel4_VladofStalker, barrel3_Jackal
    # -> barrel3_DahlJackal ...); gearData carries them as separate parts. A redirector IS its target, so it shares the
    # target's labels. (Do NOT infer aliases from identical stats: barrel3_impact and barrel3_rebounding have identical
    # numbers but different projectiles.)
    for t in G['types'].values():
        for s in t['slots'].values():
            for pid, part in s['parts'].items():
                tgt = alias_of.get((part.get('src'), pid))
                if not tgt: continue
                real = s['parts'].get(tgt[1])
                if real and real.get('src') == tgt[0]:
                    for k in ('fx', 'pfx', 'elem'):
                        if k in real and k not in part: part[k] = real[k]; nfx += (k == 'fx'); npfx += (k == 'pfx')


    # ---- Eridian energy: base recharge numbers ----
    # An Eridian weapon is an energy bar, like a shield: WeaponClipSize = capacity, CooldownRate = recharge per second,
    # FireRegenDelay = wait after firing before it recharges, OverheatCooldownDelay = lockout when it runs empty (a bigger
    # number = longer), WeaponShotCost = energy per shot. The type objects carry ClipSize/RegenRate/ShotCost/FireRegenDelay;
    # the empty-bar lockout (4 s) is only in DuncanFogg's GearTemplates.xml (CoolDelay), so read it from there and CHECK the
    # numbers it shares with the game data agree. Verified independently: these bases + the app's stacking rule reproduce
    # Lootlemon's published mag ranges exactly (capacity 83-200, regen 5.8-9.8/s, cooldown 2.7-5.2 s).
    xml = open(os.path.join(os.path.dirname(__file__), '..', '..', 'extracted', 'duncanfogg_original', 'assets', 'GearTemplates.xml'),
               encoding='utf-8', errors='replace').read()
    TEMPLATE = {'eridian_cannon': 'Eridian Cannon', 'eridian_blaster': 'Eridian Blaster', 'eridian_thunderstorm': 'Eridian Storm',
                'eridian_lightning': 'Eridian Lightning', 'eridian_railgun': 'Eridian Lightning'}
    for tid, tname in TEMPLATE.items():
        t = G['types'].get(tid)
        if not t: continue
        i = xml.index('<TargetType>' + tname + '</TargetType>'); seg = xml[i:i + 2600]
        g = lambda tag: float(re.search(r'<%s modType="\w+">([^<]+)</%s>' % (tag, tag), seg).group(1))
        b = t['base']
        assert g('ClipSize') == float(b['ClipSize']) and g('CoolRate') == float(b['RegenRate']) and g('ShotCost') == float(b['ShotCost']), \
            'Duncan template and game data disagree for ' + tid
        b['FireRegenDelay'] = str(g('FireRegenDelay'))
        b['OverheatCooldownDelay'] = str(g('CoolDelay'))

    # ---- per-type (Eridian): the red card line + the barrels the game lets the type roll ----
    p = Pkg(ROOT + '/Packages/GameData/Weapons/gd_weap_alien_rifle.upk')
    lists = {e['name']: i for i, e in enumerate(p.exports) if p.cname(e['cls']) == 'WeaponPartListDefinition'}
    flavor, pool, pools = {}, {}, {}
    for i, e in enumerate(p.exports):
        c = p.cname(e['cls'])
        if c == 'AttributePresentationDefinition' and '.WeaponType_' in p.path(i):
            d = {k: v for k, t, x, v in p.props(i)}
            if d.get('Description'): flavor[p.path(i).split('.')[2]] = d['Description']
        if c == 'WeaponTypeDefinition' and 'DELETE' not in p.path(i):
            d = {k: v for k, t, x, v in p.props(i)}
            bp = str(d.get('BarrelParts', '')).split(':')[-1]
            if bp in lists: pool[e['name']] = weighted_parts(p, lists[bp]) + EXTRA_POOL.get(e['name'], [])
            pp = {}
            for slot, key in (('Barrel', 'BarrelParts'), ('acc', 'AccessoryParts'), ('Sight', 'SightParts'), ('Stock', 'StockParts')):
                ln = str(d.get(key, '')).split(':')[-1]
                got = weighted_parts(p, lists[ln]) if ln in lists else []
                if slot == 'Barrel': got = got + EXTRA_POOL.get(e['name'], [])
                if got: pp[slot] = got
            pools[e['name']] = pp
    for tid, t in G['types'].items():
        tok = t.get('weaponTypeToken')
        if t.get('ns') == 'gd_weap_alien_rifle' and tok in pool:
            t['barrelPool'] = pool[tok]
            if pools.get(tok): t['partPools'] = pools[tok]
            if tok in flavor: t['flavor'] = flavor[tok]
            print('%-22s flavor=%-30r pools=%s' % (tid, (t.get('flavor') or '')[:28], {k: v for k, v in t.get('partPools', {}).items()}))
    print('fx on %d parts, brought-prefix on %d parts' % (nfx, npfx))

    open(GEARDATA, 'w', encoding='utf-8', newline='').write(json.dumps(G, separators=(',', ':'), ensure_ascii=False))


if __name__ == '__main__':
    main()
