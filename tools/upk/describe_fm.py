"""Profile firing modes: for each named FiringModeDefinition print its key properties, its projectile's key
properties, and the classes of the behaviors nested under that projectile (Home / Bounce / Detonate / SpawnProjectile...).
That is what a display label has to be backed by.

usage: python describe_fm.py <package.upk> <FiringModeName> [<FiringModeName> ...]
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from read_props import Pkg

SHOW = {'FireType', 'Speed', 'Lifetime', 'NumRicochets', 'bPenetratePawn', 'BeamMaxLength', 'Acceleration', 'AirFriction',
        'ProjectileDefinition', 'DamageTypeDefinition', 'bSuppressWeaponSpread', 'TraceInterval', 'WaveFreq',
        'NumBounces', 'TargetType', 'TurningRadius', 'ExplosionRadius', 'CollisionRadius', 'GravityScale', 'bFireRandomlyFromPattern'}


def profile(p, name):
    hits = [i for i, e in enumerate(p.exports) if e['name'] == name and p.cname(e['cls']) == 'FiringModeDefinition']
    if not hits: print('   (not in this package)'); return
    for i in hits:
        print('  FM', p.path(i))
        proj = None
        for k, t, x, v in p.props(i):
            if k in SHOW: print('      %-24s %s' % (k, v))
            if k == 'ProjectileDefinition': proj = str(v).split(':')[-1]
        if proj:
            pj = [j for j, e in enumerate(p.exports) if e['name'] == proj and p.cname(e['cls']) == 'ProjectileDefinition']
            for j in pj:
                print('    projectile', p.path(j))
                for k, t, x, v in p.props(j):
                    if k in SHOW: print('      %-24s %s' % (k, v))
                base = p.path(j) + '.'
                kids = sorted({(p.cname(e['cls']), e['name']) for jj, e in enumerate(p.exports) if p.path(jj).startswith(base) and jj != j
                               and p.cname(e['cls']).startswith(('ProjectileBehavior', 'Behavior_'))})
                print('      nested behaviors:', ', '.join('%s' % c for c, n in kids) or '-')
                for jj, e in enumerate(p.exports):
                    if p.path(jj).startswith(base) and p.cname(e['cls']) in ('ProjectileBehavior_Home', 'ProjectileBehavior_Bounce'):
                        for k, t, x, v in p.props(jj):
                            if k in SHOW: print('        %s.%s = %s' % (p.cname(e['cls']), k, v))


if __name__ == '__main__':
    p = Pkg(sys.argv[1])
    for n in sys.argv[2:]:
        print('==', n); profile(p, n)
