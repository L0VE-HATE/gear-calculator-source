# -*- mode: python ; coding: utf-8 -*-
import json
import os
import shutil

# Build a staged copy of web/ whose index.html carries gearData.json inside itself, so the
# exe's page never has to fetch its own data over the local server. web/ itself is untouched
# (raw dev runs still fetch gearData.json), and this runs on every build so it can't go stale.
_web = os.path.join(SPECPATH, 'web')
_stage = os.path.join(SPECPATH, 'build', 'web_staged')
if os.path.isdir(_stage):
    shutil.rmtree(_stage)
shutil.copytree(_web, _stage)
with open(os.path.join(_web, 'gearData.json'), encoding='utf-8') as _f:
    # '<' escaped so no data string can ever be read as HTML (e.g. a closing script tag)
    _data = json.dumps(json.load(_f), separators=(',', ':'), ensure_ascii=False).replace('<', '\\u003c')
_index_path = os.path.join(_stage, 'index.html')
with open(_index_path, encoding='utf-8') as _f:
    _html = _f.read()
_anchor = '<script type="importmap">'
assert _html.count(_anchor) == 1, 'inline-data anchor missing from index.html'
_html = _html.replace(_anchor, '<script id="gearDataInline" type="application/json">' + _data + '</script>\n' + _anchor)
with open(_index_path, 'w', encoding='utf-8', newline='') as _f:
    _f.write(_html)


a = Analysis(
    ['app.py'],
    pathex=[],
    binaries=[],
    datas=[(_stage, 'web')],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='GearCalculator',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='icon.ico',
)
