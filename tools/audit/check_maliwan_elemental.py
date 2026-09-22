import os
import re, json

with open(os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'app', 'web', 'index.html')), encoding="utf-8") as f:
    content = f.read()
with open(os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'app', 'web', 'gearData.json')), encoding="utf-8") as f:
    D = json.load(f)

m = re.search(r'const SAVE_BUILDS\s*=\s*\[\n(.*?)\n\];', content, re.DOTALL)
block = m.group(1)
entries = re.findall(r'\{label:"([^"]+)",\s*tid:"([^"]+)",\s*tlabel:"[^"]*",\s*manu:"([^"]*)".*?code:"((?:[^"\\]|\\.)*)"\}', block)
print('parsed', len(entries), 'entries')

ELEMENTS = {'Incendiary', 'Corrosive', 'Shock', 'Explosive'}

maliwan = [(l, tid, code) for l, tid, manu, code in entries if manu == 'Maliwan']
print(f'\nReal Maliwan-manufacturer weapons: {len(maliwan)}')
non_elemental = []
for label, tid, code in maliwan:
    lines = code.split('\\n')
    if len(lines) < 14:
        continue
    acc_line = lines[10]
    acc_pid = acc_line.split('.')[-1] if acc_line != 'None' else None
    acc_part = None
    if acc_pid:
        acc_part = D['types'][tid]['slots'].get('acc', {}).get('parts', {}).get(acc_pid)
    pn = acc_part.get('pn') if acc_part else None
    is_elemental = pn in ELEMENTS
    print(f'  {label:20s} acc={acc_pid} pn={pn} elemental={is_elemental}')
    if not is_elemental:
        non_elemental.append((label, acc_pid, pn))

print(f'\nMaliwan weapons WITHOUT an elemental accessory: {len(non_elemental)}')
for x in non_elemental:
    print(' ', x)
