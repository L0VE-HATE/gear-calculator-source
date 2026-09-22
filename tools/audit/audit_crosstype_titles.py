import os
import re, json

with open(os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'app', 'web', 'index.html')), encoding="utf-8") as f:
    content = f.read()
with open(os.path.normpath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', '..', 'app', 'web', 'gearData.json')), encoding="utf-8") as f:
    D = json.load(f)

m = re.search(r'const SAVE_BUILDS\s*=\s*\[\n(.*?)\n\];', content, re.DOTALL)
block = m.group(1)
entries = re.findall(r'\{label:"([^"]+)",\s*tid:"([^"]+)".*?code:"((?:[^"\\]|\\.)*)"\}', block)
print('parsed', len(entries), 'entries')

cross_type_titles = []
cross_type_prefixes = []
for label, tid, code in entries:
    lines = code.split('\\n')
    if len(lines) < 14:
        continue
    prefix_line, title_line = lines[12], lines[13]
    native_titles = D['types'][tid]['slots'].get('Title', {}).get('parts', {})
    native_prefixes = D['types'][tid]['slots'].get('Prefix', {}).get('parts', {})
    if title_line != 'None':
        tpid = title_line.split('.')[-1]
        if tpid not in native_titles:
            cross_type_titles.append((label, tid, title_line))
    if prefix_line != 'None':
        ppid = prefix_line.split('.')[-1]
        if ppid not in native_prefixes and ppid not in D.get('sharedPrefixes', {}):
            cross_type_prefixes.append((label, tid, prefix_line))

print()
print("Real weapons whose TITLE is not in their own type's native Title list:", len(cross_type_titles))
for x in cross_type_titles[:25]:
    print(" ", x)
print()
print("Real weapons whose PREFIX is not in their own type's native/shared Prefix list:", len(cross_type_prefixes))
for x in cross_type_prefixes[:25]:
    print(" ", x)
