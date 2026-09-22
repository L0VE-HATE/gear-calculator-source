"""Builds the single standalone GearCalculator.exe.

What it makes: one exe that carries its own Chromium engine (Electron), the calculator's files
(app/web, with gearData.json embedded in the page) and a small launcher. First launch on a PC
unpacks it once into a hidden ".gearcalc" folder beside the exe; later launches are instant.
Nothing is installed and nothing depends on the PC (no WebView2, no local server, no registry).

Usage (run in the foreground, from anywhere):
    python build.py [work_dir]        work_dir defaults to <project parent>\\gc_build_tmp
Output: <work_dir>\\out\\GearCalculator.exe   (copy it over the real exe after testing)
The Electron download is kept in work_dir between builds; delete work_dir when finished.
"""
import json
import os
import shutil
import subprocess
import sys
import time
import urllib.request
import zipfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.normpath(os.path.join(HERE, "..", ".."))          # project root
WEB = os.path.join(ROOT, "app", "web")
ICON = os.path.join(ROOT, "app", "icon.ico")
ELECTRON_VERSION = "44.4.3"
URL = ("https://github.com/electron/electron/releases/download/v%s/electron-v%s-win32-x64.zip"
       % (ELECTRON_VERSION, ELECTRON_VERSION))
CSC = os.path.join(os.environ.get("WINDIR", r"C:\Windows"), "Microsoft.NET", "Framework64", "v4.0.30319", "csc.exe")

work = os.path.abspath(sys.argv[1]) if len(sys.argv) > 1 else os.path.join(os.path.dirname(ROOT), "gc_build_tmp")
os.makedirs(work, exist_ok=True)
stage, app_dir, out_dir = (os.path.join(work, n) for n in ("stage", "app_dir", "out"))
for d in (stage, app_dir, out_dir):
    shutil.rmtree(d, ignore_errors=True)
os.makedirs(out_dir)

# 1. Electron (the browser engine) - downloaded once, reused for later builds
zip_path = os.path.join(work, "electron-%s.zip" % ELECTRON_VERSION)
if not os.path.exists(zip_path):
    print("downloading Electron %s ..." % ELECTRON_VERSION, flush=True)
    urllib.request.urlretrieve(URL, zip_path + ".part")
    os.replace(zip_path + ".part", zip_path)

# 2. Stage the calculator: copy app/web and embed gearData.json into the page itself
print("staging calculator files ...", flush=True)
shutil.copytree(WEB, stage)
with open(os.path.join(WEB, "gearData.json"), encoding="utf-8") as f:
    data = json.dumps(json.load(f), separators=(",", ":"), ensure_ascii=False).replace("<", "\\u003c")
index = os.path.join(stage, "index.html")
with open(index, encoding="utf-8") as f:
    html = f.read()
anchor = '<script type="importmap">'
assert html.count(anchor) == 1, "inline-data anchor missing from index.html"
html = html.replace(anchor, '<script id="gearDataInline" type="application/json">' + data + "</script>\n" + anchor)
with open(index, "w", encoding="utf-8", newline="") as f:
    f.write(html)

# 3. Assemble the app folder
print("assembling app folder ...", flush=True)
with zipfile.ZipFile(zip_path) as z:
    z.extractall(app_dir)
os.replace(os.path.join(app_dir, "electron.exe"), os.path.join(app_dir, "Gear Calculator.exe"))
res = os.path.join(app_dir, "resources")
default_asar = os.path.join(res, "default_app.asar")
if os.path.exists(default_asar):
    os.remove(default_asar)
loc = os.path.join(app_dir, "locales")            # English only - the app is English-only
for name in os.listdir(loc):
    if name != "en-US.pak":
        os.remove(os.path.join(loc, name))
os.makedirs(os.path.join(res, "app"))
shutil.copy(os.path.join(HERE, "main.js"), os.path.join(res, "app", "main.js"))
with open(os.path.join(res, "app", "package.json"), "w") as f:
    json.dump({"name": "gear-calculator", "version": "1.0.0", "main": "main.js"}, f)
shutil.copytree(stage, os.path.join(res, "web"))
shutil.copy(ICON, os.path.join(res, "icon.ico"))

# 4. Zip it (this zip gets embedded inside the exe)
print("compressing ...", flush=True)
app_zip = os.path.join(work, "app.zip")
with zipfile.ZipFile(app_zip, "w", zipfile.ZIP_DEFLATED, compresslevel=6) as z:
    for base, _dirs, files in os.walk(app_dir):
        for fn in files:
            full = os.path.join(base, fn)
            z.write(full, os.path.relpath(full, app_dir).replace(os.sep, "/"))

# 5. Compile the launcher with the C# compiler that ships with Windows
build_id = time.strftime("%Y%m%d-%H%M%S")
id_file = os.path.join(work, "build_id.txt")
with open(id_file, "w") as f:
    f.write(build_id)
exe = os.path.join(out_dir, "GearCalculator.exe")
print("building exe ...", flush=True)
subprocess.run([
    CSC, "/nologo", "/optimize+", "/target:winexe", "/out:" + exe, "/win32icon:" + ICON,
    "/resource:%s,app.zip" % app_zip, "/resource:%s,build_id.txt" % id_file,
    "/reference:System.Windows.Forms.dll", "/reference:System.Drawing.dll",
    "/reference:System.IO.Compression.dll", "/reference:System.IO.Compression.FileSystem.dll",
    os.path.join(HERE, "launcher.cs"),
], check=True)
os.remove(app_zip)
print("built %s  (%.0f MB, build id %s)" % (exe, os.path.getsize(exe) / 1048576, build_id))
