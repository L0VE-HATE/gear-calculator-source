import { MANUFACTURER_TINT, REAL_MATERIAL_BY_PID, TYPE_PKG } from './viewer3d.js';

// Flat 2D weapon-card art, assembled from DuncanFogg's original Gear Calculator's own real
// part images (gearcalc.50webs.com/assets/ScaledParts, recovered by decompiling GearCalcApp.swf
// with JPEXS FFDec) - not a 3D render, and not the earlier wiki-sprite-sheet attempt this file
// used to hold.
//
// The previous version of this file needed a hand-calibrated pixel offset per part per weapon
// type (see git history) because the wiki reference sheets it drew from only center each part
// neatly in its own browsing cell - not an assembly template - so a part's raw cell position
// didn't line up with where it actually belongs on the gun. That's why the card became a 3D
// render in the first place: 3D sidesteps the alignment problem entirely by using the game's
// own mesh attachment points instead of guessed offsets.
//
// DuncanFogg's assets don't have that problem. Every image in one weapon-type folder shares a
// single canvas size, with the part already pre-positioned correctly within it - so compositing
// is just "draw each selected part's full image on top of the last, in the right z-order", with
// zero per-part coordinates to find or tune. Verified by literally stacking them (Body+Barrel+
// Grip+Mag+Sight+Stock for a base SMG) and getting a correctly-assembled gun with no manual
// nudging at all.

// Folder-name -> weapon-type-id groups, recovered from ImageBinCombined.xml. DuncanFogg's own
// tool used these same groupings (confirmed independently via gearcalc.card.CardFactory.
// resolveClaptrap()'s weapon-type-name matching): Combat Rifle and Support MG share "Rifle",
// Repeater Pistol and Machine Pistol share "Repeater", Grenade/Rocket Launcher share
// "Launcher", and every Eridian type shares "Eridian" (which only ever had Body art to begin
// with - Duncan's tool never drew Eridian barrels/sights/etc, so neither do we).
const DUNCAN_FOLDER = {
  patrol_smg: 'SMG',
  revolver_pistol: 'Revolver',
  repeater_pistol: 'Repeater', machine_pistol: 'Repeater',
  combat_rifle: 'Rifle', support_machinegun: 'Rifle',
  combat_shotgun: 'Shotgun', assault_shotgun: 'Shotgun',
  sniper_rifle: 'Sniper', sniper_rifle_semiauto: 'Sniper',
  grenade_launcher: 'Launcher', rocket_launcher: 'Launcher',
  eridian_cannon: 'Eridian', eridian_blaster: 'Eridian', eridian_thunderstorm: 'Eridian',
  eridian_lightning: 'Eridian', eridian_railgun: 'Eridian',
};

// Exact z-order recovered from ImageBinCombined.xml's <PriorityManager> blocks (Rifle and
// Repeater have explicit per-type overrides there) and gearcalc.card.DrawPriorityManager.as's
// hardcoded STANDARD_MANAGER fallback for every other type. Lower Priority number = drawn
// first/further back; the list below is already sorted ascending, so a straight left-to-right
// draw gives the same stacking DuncanFogg's own sortPriorities() produced.
const LAYER_ORDER = {
  Rifle: ['acc', 'Sight', 'Stock', 'Body', 'Barrel', 'Grip', 'mag'],
  Repeater: ['acc', 'Sight', 'mag', 'Barrel', 'Action', 'Body', 'Grip'],
  STANDARD: ['acc', 'Sight', 'Stock', 'Action', 'Body', 'Grip', 'mag', 'Barrel'],
};

const SLOT_FILE_PREFIX = { Body: 'body', Grip: 'grip', mag: 'mag', Barrel: 'barrel', Sight: 'sight', Stock: 'stock', Action: 'action', acc: 'acc' };

// Which slots take the manufacturer's material tint - the same set the (now-removed)
// wiki-sprite version used: the gun's own frame/barrel/stock/sight/magazine/action, not the
// accessory (its own art - an element icon, a scope, etc - is already the right final color)
// or the grip (native art reads dark/black regardless of manufacturer in the real game too).
const SLOT_TINT_ROLE = { Body: 'tint', Barrel: 'tint', Stock: 'tint', Sight: 'tint', Action: 'tint', mag: 'tint', Grip: null, acc: null };

function hexToRatio(hex) {
  const n = parseInt(hex.replace('#', ''), 16);
  const r = (n >> 16) & 255, g = (n >> 8) & 255, b = n & 255;
  const mx = Math.max(r, g, b, 1);
  return [r / mx, g / mx, b / mx];
}

// The real game shader tints by multiplying the base texture's own RGB by a color parameter,
// not a hue/saturation replace - confirmed against the game's own Maliwan_Material_3 data
// (weap_materials_master.upk) and independently against real screenshot pixel sampling (see
// viewer3d.js's REAL_MATERIAL). Other manufacturers fall back to a ratio derived from the
// older screenshot-sampled MANUFACTURER_TINT hex until they get the same real-data treatment.
const REAL_TINT_RATIO = { Maliwan: [0.45, 0.58, 1.0] };

// Same blend weight the Maliwan-only REAL_TINT_RATIO above works out to (reverse-engineered
// from it: metal_color/composite_color blended roughly 88/12 reproduces [0.45,0.58,1.0] from
// Maliwan_3's own real metal=[0.5,0.6,1.0]/composite=[1/6,1/3,1.0]) - applied generically to
// every material in REAL_MATERIAL_BY_PID so they all get the same treatment as Maliwan did.
const REAL_BLEND_WEIGHT = 0.88;

function blendReal(real) {
  const blend = [0, 1, 2].map((i) => REAL_BLEND_WEIGHT * real.metal[i] + (1 - REAL_BLEND_WEIGHT) * real.composite[i]);
  const mx = Math.max(...blend, 0.0001);
  return blend.map((v) => v / mx);
}

function tintRatioFor(manuTok, materialId) {
  const real = REAL_MATERIAL_BY_PID[materialId];
  if (real) return blendReal(real);
  const key = Object.keys(REAL_TINT_RATIO).find((k) => k.toLowerCase() === (manuTok || '').toLowerCase());
  if (key) return REAL_TINT_RATIO[key];
  const tintKey = Object.keys(MANUFACTURER_TINT).find((k) => k.toLowerCase() === (manuTok || '').toLowerCase());
  return tintKey ? hexToRatio(MANUFACTURER_TINT[tintKey][0]) : null;
}

// ---- Per-part tint (every material that has real game color data) ----
// The 3D viewer's shader picks metal or composite color PER PIXEL from the weapon's own mask.png. The 2D sprites have no
// such mask, so the old code used ONE global blend (88% metal / 12% composite, tuned on a Maliwan screenshot) for every
// part - which is wrong for most parts (the real composite share is 26-63% on average and 0-100% part by part) and
// turned the seven black-metal materials (Vladof tier 3, Atlas tier 3, Bessie, Nailer, Sentinel, Undertaker, Revenge)
// into a solid bright composite color (Vladof tier 3 = an all-orange gun). Each PART does have a real average:
// partShare.json (tools/prep_part_composite_share.py, read from the same mask.png + meshes the 3D uses) holds, per
// part, the share of its surface that is composite and how much of it the mask covers at all. Uncovered surface is
// the shader's neutral dark "natural" tone (0.55, drawn here relative to the PRE_BRIGHTEN'd art). Materials without
// real color data, and parts without an entry (grenade launcher, Eridian), keep the old single ratio.
let partShare = null;
async function loadPartShare() {
  if (partShare) return partShare;
  try { const r = await fetch('partShare.json'); partShare = r.ok ? await r.json() : {}; } catch (e) { partShare = {}; }
  return partShare;
}
function partTintRatio(real, share, cov) {
  const natural = 0.55 / PRE_BRIGHTEN;
  return [0, 1, 2].map((i) => cov * ((1 - share) * real.metal[i] + share * real.composite[i]) + (1 - cov) * natural);
}

const recolorCache = new Map(); // "url/manuTok" -> HTMLCanvasElement
// DuncanFogg's part art is drawn darker than the real target brightness, so a straight
// multiply only ever darkens further - pre-brighten first so highlights and mid-tones land in
// the right range once the tint ratio is applied (same fix the wiki-sprite version needed).
const PRE_BRIGHTEN = 1.9;

function recolorImg(img, key, ratio) {
  if (recolorCache.has(key)) return recolorCache.get(key);
  const c = document.createElement('canvas');
  c.width = img.naturalWidth; c.height = img.naturalHeight;
  const cx = c.getContext('2d');
  cx.drawImage(img, 0, 0);
  const imgData = cx.getImageData(0, 0, c.width, c.height);
  const d = imgData.data;
  for (let i = 0; i < d.length; i += 4) {
    if (d[i + 3] === 0) continue;
    d[i] = Math.min(255, d[i] * PRE_BRIGHTEN) * ratio[0];
    d[i + 1] = Math.min(255, d[i + 1] * PRE_BRIGHTEN) * ratio[1];
    d[i + 2] = Math.min(255, d[i + 2] * PRE_BRIGHTEN) * ratio[2];
  }
  cx.putImageData(imgData, 0, 0);
  recolorCache.set(key, c);
  return c;
}

// Exact ColorTransform target colors from gearcalc.card.GraphicsRepository.MASK_* in the
// recovered source (0x64FF73/0xFFFFBF/0x817BFF/0xFF2E2E) - not approximated from a screenshot.
// Applied over a part's own "-mask.png" (a stencil of just the area that recolors), matching
// the original's changeElementalColor() with its blend factor pinned to 1 (full target color,
// not a partial mix) - see DrawablePart.as.
const ELEMENT_TINT = { Incendiary: [255, 46, 46], Corrosive: [100, 255, 115], Shock: [129, 123, 255], Explosive: [255, 255, 191] };

// Same "prefix+digit search anywhere in the id" trick as viewer3d.js's meshBaseName() - a
// weapon-type folder only has plain numbered files (body5.png) while an equipped part id can
// carry a unique name on either side of the number (mag1_thumper, BoneShredder_mag5).
function partFileNum(slot, partId) {
  if (!partId || /none/i.test(partId)) return null;
  const prefix = SLOT_FILE_PREFIX[slot];
  if (!prefix) return null;
  const m = new RegExp(prefix + '([0-9]+)', 'i').exec(partId);
  return m ? m[1] : null;
}

const imgCache = new Map(); // url -> Promise<HTMLImageElement|null>
function loadImg(url) {
  if (imgCache.has(url)) return imgCache.get(url);
  const p = new Promise((resolve) => {
    const img = new Image();
    img.onload = () => resolve(img);
    img.onerror = () => resolve(null);
    img.src = url;
  });
  imgCache.set(url, p);
  return p;
}

// DuncanFogg's numbering doesn't cover every 1-5 slot value in every folder (e.g. Launcher
// has no body2/barrel3/stock1 - he only drew the numbers his own tool's data actually used).
// Rather than leave a structural part invisible on the card, fall back to the closest numbered
// variant that DOES exist for that slot - visually a much better stand-in than a gap, since
// same-slot variants in one folder are all close in size/shape (they're the same weapon part,
// just a different tier).
async function loadClosest(folder, prefix, num) {
  const wanted = parseInt(num, 10);
  const candidates = [wanted];
  for (let d = 1; d <= 6; d++) { candidates.push(wanted - d); candidates.push(wanted + d); }
  for (const n of candidates) {
    if (n < 1 || n > 9) continue;
    const url = `vendor/duncan/parts/${folder}/${prefix}${n}.png`;
    const img = await loadImg(url);
    if (img) return { img, num: n, baseUrl: url };
  }
  return null;
}

const maskTintCache = new Map(); // "url/r,g,b" -> Promise<HTMLCanvasElement|null>
function tintedMask(url, rgb) {
  const key = url + '/' + rgb.join(',');
  if (maskTintCache.has(key)) return maskTintCache.get(key);
  const p = (async () => {
    const img = await loadImg(url);
    if (!img) return null;
    const c = document.createElement('canvas');
    c.width = img.naturalWidth; c.height = img.naturalHeight;
    const cx = c.getContext('2d');
    cx.drawImage(img, 0, 0);
    // source-in keeps the mask's own alpha shape but replaces every visible pixel's color -
    // the flat-recolor equivalent of a ColorTransform blended fully to the target (factor=1).
    cx.globalCompositeOperation = 'source-in';
    cx.fillStyle = `rgb(${rgb[0]},${rgb[1]},${rgb[2]})`;
    cx.fillRect(0, 0, c.width, c.height);
    return c;
  })();
  maskTintCache.set(key, p);
  return p;
}

// A tight trim (zero margin) makes object-fit:contain blow the gun up to fill the whole
// card-viewport edge-to-edge - noticeably more "zoomed in" than the real card, which always
// leaves breathing room around the gun. PAD adds that margin back, as a fraction of the
// trimmed bounding box's larger dimension, split evenly on all sides.
const PAD = 0.16;

function trimCanvas(canvas) {
  const ctx = canvas.getContext('2d');
  const { data, width, height } = ctx.getImageData(0, 0, canvas.width, canvas.height);
  let x0 = width, y0 = height, x1 = 0, y1 = 0, any = false;
  for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
      if (data[(y * width + x) * 4 + 3] > 8) {
        any = true;
        if (x < x0) x0 = x; if (x > x1) x1 = x;
        if (y < y0) y0 = y; if (y > y1) y1 = y;
      }
    }
  }
  if (!any) return canvas;
  const w = x1 - x0 + 1, h = y1 - y0 + 1;
  const pad = Math.round(Math.max(w, h) * PAD);
  const out = document.createElement('canvas');
  out.width = w + pad * 2; out.height = h + pad * 2;
  out.getContext('2d').drawImage(canvas, x0, y0, w, h, pad, pad, w, h);
  return out;
}

let genCounter = 0;

// elementName: one of 'Incendiary'/'Corrosive'/'Shock'/'Explosive', or null/undefined.
// materialId: the selected Material part's own pid (sel.Material?.id) - takes priority over
// manuTok for tinting when we have real per-material data (see tintRatioFor above).
export async function update2DViewer(typeId, sel, manuTok, elementName, materialId) {
  const folder = DUNCAN_FOLDER[typeId];
  const img = document.getElementById('v3d_img');
  const empty = document.getElementById('v3d_empty');
  if (!img) return false;
  if (!folder) {
    img.hidden = true;
    if (empty) { empty.hidden = false; empty.textContent = 'No 2D card art for this weapon type'; }
    return false;
  }

  const gen = ++genCounter;
  const order = LAYER_ORDER[folder] || LAYER_ORDER.STANDARD;
  const layerSpecs = order.map((slot) => {
    const part = sel[slot];
    const num = part ? partFileNum(slot, part.id) : null;
    if (!num) return null;
    return { slot, prefix: SLOT_FILE_PREFIX[slot], num };
  });

  const loaded = await Promise.all(layerSpecs.map(async (spec) => {
    if (!spec) return null;
    const hit = await loadClosest(folder, spec.prefix, spec.num);
    if (!hit) return null;
    return { slot: spec.slot, baseUrl: hit.baseUrl, base: hit.img, partName: spec.prefix + hit.num, maskUrl: `vendor/duncan/parts/${folder}/${spec.prefix}${hit.num}-mask.png` };
  }));
  if (gen !== genCounter) return true;

  if (!loaded.some(Boolean)) {
    img.hidden = true;
    if (empty) { empty.hidden = false; empty.textContent = 'No parts selected'; }
    return true;
  }

  const first = loaded.find(Boolean).base;
  const canvas = document.createElement('canvas');
  canvas.width = first.naturalWidth;
  canvas.height = first.naturalHeight;
  const ctx = canvas.getContext('2d');
  const tintRatio = tintRatioFor(manuTok, materialId);
  const realMat = REAL_MATERIAL_BY_PID[materialId];
  const shares = realMat ? ((await loadPartShare())[TYPE_PKG[typeId]] || null) : null;
  if (gen !== genCounter) return true;

  const tint = elementName ? ELEMENT_TINT[elementName] : null;
  for (const layer of loaded) {
    if (!layer) continue;
    let baseImg = layer.base;
    if (tintRatio && SLOT_TINT_ROLE[layer.slot] === 'tint') {
      const ps = shares && shares[layer.partName];   // [composite share, mask coverage] from the game's own mask
      baseImg = ps
        ? recolorImg(baseImg, layer.baseUrl + '/' + materialId + '/perpart', partTintRatio(realMat, ps[0], ps[1]))
        : recolorImg(baseImg, layer.baseUrl + '/' + (materialId || manuTok), tintRatio);
    }
    ctx.drawImage(baseImg, 0, 0);
    if (tint) {
      const tinted = await tintedMask(layer.maskUrl, tint);
      if (gen !== genCounter) return true;
      if (tinted) ctx.drawImage(tinted, 0, 0);
    }
  }

  const trimmed = trimCanvas(canvas);
  img.src = trimmed.toDataURL('image/png');
  img.hidden = false;
  if (empty) empty.hidden = true;
  return true;
}

window.update2DViewer = update2DViewer;

// ============================================================================
// ---- Shields ----
// Unlike weapons, Duncan's own ImageBinCombined.xml already ships a FULL per-manufacturer/
// material reskin set for every Shield Body/Left/Right part (<Textured ref="x3NN">...</Textured>
// - 31 real materials x 9 part-groups, no math-derived tint needed at all) - just never
// downloaded before now (only the plain "-Base.png" files were on disk). Fetched from the same
// still-live 2010 host every other Duncan asset in this project came from (build_shield_data.py's
// sibling fetch_shield_art.py), so shields reach the same "real art, not an approximation" bar
// weapons did, straight away rather than needing a follow-up UModel pass.
const SHIELD_SLOT_FOLDER = { sBody: 'ShieldBody', sLeft: 'ShieldLeft', sRight: 'ShieldRight' };
// Draw order from DrawPriorityManager.as's hardcoded STANDARD_MANAGER (confirmed real values):
// SHIELD_LEFT=40 < SHIELD_RIGHT=42 < SHIELD_BODY=50 - Body paints last/on top.
const SHIELD_LAYER_ORDER = ['sLeft', 'sRight', 'sBody'];
// pid -> {file: "<letter><n>-Base.png", textured: {materialPid: "<letter><n>-<Manufacturer>.png"}}
// generated by fetch_shield_art.py straight from ImageBinCombined.xml's own <Def>/<Textured>
// entries - see that script for the full derivation, not hand-transcribed.
const SHIELD_PID_FILE = {"rightside1":{"file":"A1-Base.png","textured":{"x332":"A1-WeeWee.png","x331":"A1-CrackedSash.png","x330":"A1-Vladof3.png","x329":"A1-Vladof2.png","x328":"A1-Vladof1.png","x327":"A1-Torgue3.png","x326":"A1-Torgue2.png","x325":"A1-Torgue1.png","x324":"A1-Tediore3.png","x323":"A1-Tediore2.png","x322":"A1-Tediore1.png","x320":"A1-SandS2.png","x319":"A1-SandS2.png","x318":"A1-SandS1.png","x317":"A1-Pangolin.png","x316":"A1-Pangolin.png","x315":"A1-Pangolin.png","x314":"A1-Maliwan2.png","x313":"A1-Maliwan2.png","x312":"A1-Maliwan1.png","x311":"A1-Hyperion3.png","x310":"A1-Hyperion2.png","x309":"A1-Hyperion1.png","x308":"A1-Dahl3.png","x307":"A1-Dahl2.png","x306":"A1-Dahl1.png","x305":"A1-Atlas3.png","x304":"A1-Atlas2.png","x303":"A1-Atlas1.png","x302":"A1-Anshin.png","x301":"A1-Anshin.png","x300":"A1-Anshin.png"}},"rightside2":{"file":"A2-Base.png","textured":{"x332":"A2-WeeWee.png","x331":"A2-CrackedSash.png","x330":"A2-Vladof3.png","x329":"A2-Vladof2.png","x328":"A2-Vladof1.png","x327":"A2-Torgue3.png","x326":"A2-Torgue2.png","x325":"A2-Torgue1.png","x324":"A2-Tediore3.png","x323":"A2-Tediore2.png","x322":"A2-Tediore1.png","x320":"A2-SandS2.png","x319":"A2-SandS2.png","x318":"A2-SandS1.png","x317":"A2-Pangolin.png","x316":"A2-Pangolin.png","x315":"A2-Pangolin.png","x314":"A2-Maliwan2.png","x313":"A2-Maliwan2.png","x312":"A2-Maliwan1.png","x311":"A2-Hyperion3.png","x310":"A2-Hyperion2.png","x309":"A2-Hyperion1.png","x308":"A2-Dahl3.png","x307":"A2-Dahl2.png","x306":"A2-Dahl1.png","x305":"A2-Atlas3.png","x304":"A2-Atlas2.png","x303":"A2-Atlas1.png","x302":"A2-Anshin.png","x301":"A2-Anshin.png","x300":"A2-Anshin.png"}},"rightside3":{"file":"A3-Base.png","textured":{"x332":"A3-WeeWee.png","x331":"A3-CrackedSash.png","x330":"A3-Vladof3.png","x329":"A3-Vladof2.png","x328":"A3-Vladof1.png","x327":"A3-Torgue3.png","x326":"A3-Torgue2.png","x325":"A3-Torgue1.png","x324":"A3-Tediore3.png","x323":"A3-Tediore2.png","x322":"A3-Tediore1.png","x320":"A3-SandS2.png","x319":"A3-SandS2.png","x318":"A3-SandS1.png","x317":"A3-Pangolin.png","x316":"A3-Pangolin.png","x315":"A3-Pangolin.png","x314":"A3-Maliwan2.png","x313":"A3-Maliwan2.png","x312":"A3-Maliwan1.png","x311":"A3-Hyperion3.png","x310":"A3-Hyperion2.png","x309":"A3-Hyperion1.png","x308":"A3-Dahl3.png","x307":"A3-Dahl2.png","x306":"A3-Dahl1.png","x305":"A3-Atlas3.png","x304":"A3-Atlas2.png","x303":"A3-Atlas1.png","x302":"A3-Anshin.png","x301":"A3-Anshin.png","x300":"A3-Anshin.png"}},"rightside4":{"file":"A4-Base.png","textured":{"x332":"A4-WeeWee.png","x331":"A4-CrackedSash.png","x330":"A4-Vladof3.png","x329":"A4-Vladof2.png","x328":"A4-Vladof1.png","x327":"A4-Torgue1-3.png","x326":"A4-Torgue1-3.png","x325":"A4-Torgue1-3.png","x324":"A4-Tediore3.png","x323":"A4-Tediore2.png","x322":"A4-Tediore1.png","x320":"A4-SandS2.png","x319":"A4-SandS2.png","x318":"A4-SandS1.png","x317":"A4-Pangolin.png","x316":"A4-Pangolin.png","x315":"A4-Pangolin.png","x314":"A4-Maliwan2.png","x313":"A4-Maliwan2.png","x312":"A4-Maliwan1.png","x311":"A4-Hyperion3.png","x310":"A4-Hyperion2.png","x309":"A4-Hyperion1.png","x308":"A4-Dahl3.png","x307":"A4-Dahl2.png","x306":"A4-Dahl1.png","x305":"A4-Atlas3.png","x304":"A4-Atlas2.png","x303":"A4-Atlas1.png","x302":"A4-Anshin.png","x301":"A4-Anshin.png","x300":"A4-Anshin.png"}},"leftside1":{"file":"B1-Base.png","textured":{"x332":"B1-WeeWee.png","x331":"B1-CrackedSash.png","x330":"B1-Vladof3.png","x329":"B1-Vladof2.png","x328":"B1-Vladof1.png","x327":"B1-Torgue3.png","x326":"B1-Torgue2.png","x325":"B1-Torgue1.png","x324":"B1-Tediore3.png","x323":"B1-Tediore2.png","x322":"B1-Tediore1.png","x320":"B1-SandS2.png","x319":"B1-SandS2.png","x318":"B1-SandS1.png","x317":"B1-Pangolin.png","x316":"B1-Pangolin.png","x315":"B1-Pangolin.png","x314":"B1-Maliwan2.png","x313":"B1-Maliwan2.png","x312":"B1-Maliwan1.png","x311":"B1-Hyperion3.png","x310":"B1-Hyperion2.png","x309":"B1-Hyperion1.png","x308":"B1-Dahl3.png","x307":"B1-Dahl2.png","x306":"B1-Dahl1.png","x305":"B1-Atlas3.png","x304":"B1-Atlas2.png","x303":"B1-Atlas1.png","x302":"B1-Anshin.png","x301":"B1-Anshin.png","x300":"B1-Anshin.png"}},"leftside2":{"file":"B2-Base.png","textured":{"x332":"B2-WeeWee.png","x331":"B2-CrackedSash.png","x330":"B2-Vladof3.png","x329":"B2-Vladof2.png","x328":"B2-Vladof1.png","x327":"B2-Torgue3.png","x326":"B2-Torgue2.png","x325":"B2-Torgue1.png","x324":"B2-Tediore3.png","x323":"B2-Tediore2.png","x322":"B2-Tediore1.png","x320":"B2-SandS2.png","x319":"B2-SandS2.png","x318":"B2-SandS1.png","x317":"B2-Pangolin.png","x316":"B2-Pangolin.png","x315":"B2-Pangolin.png","x314":"B2-Maliwan2.png","x313":"B2-Maliwan2.png","x312":"B2-Maliwan1.png","x311":"B2-Hyperion3.png","x310":"B2-Hyperion2.png","x309":"B2-Hyperion1.png","x308":"B2-Dahl3.png","x307":"B2-Dahl2.png","x306":"B2-Dahl1.png","x305":"B2-Atlas3.png","x304":"B2-Atlas2.png","x303":"B2-Atlas1.png","x302":"B2-Anshin.png","x301":"B2-Anshin.png","x300":"B2-Anshin.png"}},"leftside3":{"file":"B3-Base.png","textured":{"x332":"B3-WeeWee.png","x331":"B3-CrackedSash.png","x330":"B3-Vladof3.png","x329":"B3-Vladof2.png","x328":"B3-Vladof1.png","x327":"B3-Torgue3.png","x326":"B3-Torgue2.png","x325":"B3-Torgue1.png","x324":"B3-Tediore3.png","x323":"B3-Tediore2.png","x322":"B3-Tediore1.png","x320":"B3-SandS2.png","x319":"B3-SandS2.png","x318":"B3-SandS1.png","x317":"B3-Pangolin.png","x316":"B3-Pangolin.png","x315":"B3-Pangolin.png","x314":"B3-Maliwan2.png","x313":"B3-Maliwan2.png","x312":"B3-Maliwan1.png","x311":"B3-Hyperion3.png","x310":"B3-Hyperion2.png","x309":"B3-Hyperion1.png","x308":"B3-Dahl3.png","x307":"B3-Dahl2.png","x306":"B3-Dahl1.png","x305":"B3-Atlas3.png","x304":"B3-Atlas2.png","x303":"B3-Atlas1.png","x302":"B3-Anshin.png","x301":"B3-Anshin.png","x300":"B3-Anshin.png"}},"leftside4":{"file":"B4-Base.png","textured":{"x332":"B4-WeeWee.png","x331":"B4-CrackedSash.png","x330":"B4-Vladof3.png","x329":"B4-Vladof2.png","x328":"B4-Vladof1.png","x327":"B4-Torgue3.png","x326":"B4-Torgue2.png","x325":"B4-Torgue1.png","x324":"B4-Tediore3.png","x323":"B4-Tediore2.png","x322":"B4-Tediore1.png","x320":"B4-SandS2.png","x319":"B4-SandS2.png","x318":"B4-SandS1.png","x317":"B4-Pangolin.png","x316":"B4-Pangolin.png","x315":"B4-Pangolin.png","x314":"B4-Maliwan2.png","x313":"B4-Maliwan2.png","x312":"B4-Maliwan1.png","x311":"B4-Hyperion3.png","x310":"B4-Hyperion2.png","x309":"B4-Hyperion1.png","x308":"B4-Dahl3.png","x307":"B4-Dahl2.png","x306":"B4-Dahl1.png","x305":"B4-Atlas3.png","x304":"B4-Atlas2.png","x303":"B4-Atlas1.png","x302":"B4-Anshin.png","x301":"B4-Anshin.png","x300":"B4-Anshin.png"}},"body1":{"file":"C1-Base.png","textured":{"x332":"C1-WeeWee.png","x331":"C1-CrackedSash.png","x330":"C1-Vladof3.png","x329":"C1-Vladof2.png","x328":"C1-Vladof1.png","x327":"C1-Torgue3.png","x326":"C1-Torgue2.png","x325":"C1-Torgue1.png","x324":"C1-Tediore3.png","x323":"C1-Tediore2.png","x322":"C1-Tediore1.png","x320":"C1-SandS2.png","x319":"C1-SandS2.png","x318":"C1-SandS1.png","x317":"C1-Pangolin.png","x316":"C1-Pangolin.png","x315":"C1-Pangolin.png","x314":"C1-Maliwan2.png","x313":"C1-Maliwan2.png","x312":"C1-Maliwan1.png","x311":"C1-Hyperion3.png","x310":"C1-Hyperion2.png","x309":"C1-Hyperion1.png","x308":"C1-Dahl3.png","x307":"C1-Dahl2.png","x306":"C1-Dahl1.png","x305":"C1-Atlas3.png","x304":"C1-Atlas2.png","x303":"C1-Atlas1.png","x302":"C1-Anshin.png","x301":"C1-Anshin.png","x300":"C1-Anshin.png"}},"body1_balanced":{"file":"C1-Base.png","textured":{"x332":"C1-WeeWee.png","x331":"C1-CrackedSash.png","x330":"C1-Vladof3.png","x329":"C1-Vladof2.png","x328":"C1-Vladof1.png","x327":"C1-Torgue3.png","x326":"C1-Torgue2.png","x325":"C1-Torgue1.png","x324":"C1-Tediore3.png","x323":"C1-Tediore2.png","x322":"C1-Tediore1.png","x320":"C1-SandS2.png","x319":"C1-SandS2.png","x318":"C1-SandS1.png","x317":"C1-Pangolin.png","x316":"C1-Pangolin.png","x315":"C1-Pangolin.png","x314":"C1-Maliwan2.png","x313":"C1-Maliwan2.png","x312":"C1-Maliwan1.png","x311":"C1-Hyperion3.png","x310":"C1-Hyperion2.png","x309":"C1-Hyperion1.png","x308":"C1-Dahl3.png","x307":"C1-Dahl2.png","x306":"C1-Dahl1.png","x305":"C1-Atlas3.png","x304":"C1-Atlas2.png","x303":"C1-Atlas1.png","x302":"C1-Anshin.png","x301":"C1-Anshin.png","x300":"C1-Anshin.png"}},"body4":{"file":"C2-Base.png","textured":{"x332":"C2-WeeWee.png","x331":"C2-CrackedSash.png","x330":"C2-Vladof3.png","x329":"C2-Vladof2.png","x328":"C2-Vladof1.png","x327":"C2-Torgue3.png","x326":"C2-Torgue2.png","x325":"C2-Torgue1.png","x324":"C2-Tediore3.png","x323":"C2-Tediore2.png","x322":"C2-Tediore1.png","x320":"C2-SandS2.png","x319":"C2-SandS2.png","x318":"C2-SandS1.png","x317":"C2-Pangolin.png","x316":"C2-Pangolin.png","x315":"C2-Pangolin.png","x314":"C2-Maliwan2.png","x313":"C2-Maliwan2.png","x312":"C2-Maliwan1.png","x311":"C2-Hyperion3.png","x310":"C2-Hyperion2.png","x309":"C2-Hyperion1.png","x308":"C2-Dahl3.png","x307":"C2-Dahl2.png","x306":"C2-Dahl1.png","x305":"C2-Atlas3.png","x304":"C2-Atlas2.png","x303":"C2-Atlas1.png","x302":"C2-Anshin.png","x301":"C2-Anshin.png","x300":"C2-Anshin.png"}},"body4_CrackedSash":{"file":"C2-Base.png","textured":{"x332":"C2-WeeWee.png","x331":"C2-CrackedSash.png","x330":"C2-Vladof3.png","x329":"C2-Vladof2.png","x328":"C2-Vladof1.png","x327":"C2-Torgue3.png","x326":"C2-Torgue2.png","x325":"C2-Torgue1.png","x324":"C2-Tediore3.png","x323":"C2-Tediore2.png","x322":"C2-Tediore1.png","x320":"C2-SandS2.png","x319":"C2-SandS2.png","x318":"C2-SandS1.png","x317":"C2-Pangolin.png","x316":"C2-Pangolin.png","x315":"C2-Pangolin.png","x314":"C2-Maliwan2.png","x313":"C2-Maliwan2.png","x312":"C2-Maliwan1.png","x311":"C2-Hyperion3.png","x310":"C2-Hyperion2.png","x309":"C2-Hyperion1.png","x308":"C2-Dahl3.png","x307":"C2-Dahl2.png","x306":"C2-Dahl1.png","x305":"C2-Atlas3.png","x304":"C2-Atlas2.png","x303":"C2-Atlas1.png","x302":"C2-Anshin.png","x301":"C2-Anshin.png","x300":"C2-Anshin.png"}},"body4_Anshin_Rose":{"file":"C2-Base.png","textured":{"x332":"C2-WeeWee.png","x331":"C2-CrackedSash.png","x330":"C2-Vladof3.png","x329":"C2-Vladof2.png","x328":"C2-Vladof1.png","x327":"C2-Torgue3.png","x326":"C2-Torgue2.png","x325":"C2-Torgue1.png","x324":"C2-Tediore3.png","x323":"C2-Tediore2.png","x322":"C2-Tediore1.png","x320":"C2-SandS2.png","x319":"C2-SandS2.png","x318":"C2-SandS1.png","x317":"C2-Pangolin.png","x316":"C2-Pangolin.png","x315":"C2-Pangolin.png","x314":"C2-Maliwan2.png","x313":"C2-Maliwan2.png","x312":"C2-Maliwan1.png","x311":"C2-Hyperion3.png","x310":"C2-Hyperion2.png","x309":"C2-Hyperion1.png","x308":"C2-Dahl3.png","x307":"C2-Dahl2.png","x306":"C2-Dahl1.png","x305":"C2-Atlas3.png","x304":"C2-Atlas2.png","x303":"C2-Atlas1.png","x302":"C2-Anshin.png","x301":"C2-Anshin.png","x300":"C2-Anshin.png"}},"body4_Atlas_Omega":{"file":"C2-Base.png","textured":{"x332":"C2-WeeWee.png","x331":"C2-CrackedSash.png","x330":"C2-Vladof3.png","x329":"C2-Vladof2.png","x328":"C2-Vladof1.png","x327":"C2-Torgue3.png","x326":"C2-Torgue2.png","x325":"C2-Torgue1.png","x324":"C2-Tediore3.png","x323":"C2-Tediore2.png","x322":"C2-Tediore1.png","x320":"C2-SandS2.png","x319":"C2-SandS2.png","x318":"C2-SandS1.png","x317":"C2-Pangolin.png","x316":"C2-Pangolin.png","x315":"C2-Pangolin.png","x314":"C2-Maliwan2.png","x313":"C2-Maliwan2.png","x312":"C2-Maliwan1.png","x311":"C2-Hyperion3.png","x310":"C2-Hyperion2.png","x309":"C2-Hyperion1.png","x308":"C2-Dahl3.png","x307":"C2-Dahl2.png","x306":"C2-Dahl1.png","x305":"C2-Atlas3.png","x304":"C2-Atlas2.png","x303":"C2-Atlas1.png","x302":"C2-Anshin.png","x301":"C2-Anshin.png","x300":"C2-Anshin.png"}},"body3":{"file":"C3-Base.png","textured":{"x332":"C3-WeeWee.png","x331":"C3-CrackedSash.png","x330":"C3-Vladof3.png","x329":"C3-Vladof2.png","x328":"C3-Vladof1.png","x327":"C3-Torgue3.png","x326":"C3-Torgue2.png","x325":"C3-Torgue1.png","x324":"C3-Tediore3.png","x323":"C3-Tediore2.png","x322":"C3-Tediore1.png","x320":"C3-SandS2.png","x319":"C3-SandS2.png","x318":"C3-SandS1.png","x317":"C3-Pangolin.png","x316":"C3-Pangolin.png","x315":"C3-Pangolin.png","x314":"C3-Maliwan2.png","x313":"C3-Maliwan2.png","x312":"C3-Maliwan1.png","x311":"C3-Hyperion3.png","x310":"C3-Hyperion2.png","x309":"C3-Hyperion1.png","x308":"C3-Dahl3.png","x307":"C3-Dahl2.png","x306":"C3-Dahl1.png","x305":"C3-Atlas3.png","x304":"C3-Atlas2.png","x303":"C3-Atlas1.png","x302":"C3-Anshin.png","x301":"C3-Anshin.png","x300":"C3-Anshin.png"}},"body3b_power":{"file":"C3-Base.png","textured":{"x332":"C3-WeeWee.png","x331":"C3-CrackedSash.png","x330":"C3-Vladof3.png","x329":"C3-Vladof2.png","x328":"C3-Vladof1.png","x327":"C3-Torgue3.png","x326":"C3-Torgue2.png","x325":"C3-Torgue1.png","x324":"C3-Tediore3.png","x323":"C3-Tediore2.png","x322":"C3-Tediore1.png","x320":"C3-SandS2.png","x319":"C3-SandS2.png","x318":"C3-SandS1.png","x317":"C3-Pangolin.png","x316":"C3-Pangolin.png","x315":"C3-Pangolin.png","x314":"C3-Maliwan2.png","x313":"C3-Maliwan2.png","x312":"C3-Maliwan1.png","x311":"C3-Hyperion3.png","x310":"C3-Hyperion2.png","x309":"C3-Hyperion1.png","x308":"C3-Dahl3.png","x307":"C3-Dahl2.png","x306":"C3-Dahl1.png","x305":"C3-Atlas3.png","x304":"C3-Atlas2.png","x303":"C3-Atlas1.png","x302":"C3-Anshin.png","x301":"C3-Anshin.png","x300":"C3-Anshin.png"}},"body3_Pangolin_Ironclad":{"file":"C3-Base.png","textured":{"x332":"C3-WeeWee.png","x331":"C3-CrackedSash.png","x330":"C3-Vladof3.png","x329":"C3-Vladof2.png","x328":"C3-Vladof1.png","x327":"C3-Torgue3.png","x326":"C3-Torgue2.png","x325":"C3-Torgue1.png","x324":"C3-Tediore3.png","x323":"C3-Tediore2.png","x322":"C3-Tediore1.png","x320":"C3-SandS2.png","x319":"C3-SandS2.png","x318":"C3-SandS1.png","x317":"C3-Pangolin.png","x316":"C3-Pangolin.png","x315":"C3-Pangolin.png","x314":"C3-Maliwan2.png","x313":"C3-Maliwan2.png","x312":"C3-Maliwan1.png","x311":"C3-Hyperion3.png","x310":"C3-Hyperion2.png","x309":"C3-Hyperion1.png","x308":"C3-Dahl3.png","x307":"C3-Dahl2.png","x306":"C3-Dahl1.png","x305":"C3-Atlas3.png","x304":"C3-Atlas2.png","x303":"C3-Atlas1.png","x302":"C3-Anshin.png","x301":"C3-Anshin.png","x300":"C3-Anshin.png"}},"body2":{"file":"C4-Base.png","textured":{"x332":"C4-WeeWee.png","x331":"C4-CrackedSash.png","x330":"C4-Vladof3.png","x329":"C4-Vladof2.png","x328":"C4-Vladof1.png","x327":"C4-Torgue3.png","x326":"C4-Torgue2.png","x325":"C4-Torgue1.png","x324":"C4-Tediore3.png","x323":"C4-Tediore2.png","x322":"C4-Tediore1.png","x320":"C4-SandS2.png","x319":"C4-SandS2.png","x318":"C4-SandS1.png","x317":"C4-Pangolin.png","x316":"C4-Pangolin.png","x315":"C4-Pangolin.png","x314":"C4-Maliwan2.png","x313":"C4-Maliwan2.png","x312":"C4-Maliwan1.png","x311":"C4-Hyperion3.png","x310":"C4-Hyperion2.png","x309":"C4-Hyperion1.png","x308":"C4-Dahl3.png","x307":"C4-Dahl2.png","x306":"C4-Dahl1.png","x305":"C4-Atlas3.png","x304":"C4-Atlas2.png","x303":"C4-Atlas1.png","x302":"C4-Anshin.png","x301":"C4-Anshin.png","x300":"C4-Anshin.png"}}};

export async function update2DViewerShield(sel, manuTok, materialId) {
  const img = document.getElementById('v3d_img');
  const empty = document.getElementById('v3d_empty');
  if (!img) return false;
  const gen = ++genCounter;

  const loaded = [];
  for (const slot of SHIELD_LAYER_ORDER) {
    const part = sel[slot];
    if (!part || !part.id) continue;
    const info = SHIELD_PID_FILE[part.id];
    if (!info) continue;
    const folder = SHIELD_SLOT_FOLDER[slot];
    const texturedFile = materialId && info.textured[materialId];
    const file = texturedFile || info.file;
    const base = await loadImg(`vendor/duncan/parts/${folder}/${file}`);
    if (gen !== genCounter) return true;
    if (base) loaded.push({ base, real: !!texturedFile });
  }

  if (!loaded.length) {
    img.hidden = true;
    if (empty) { empty.hidden = false; empty.textContent = 'No parts selected'; }
    return true;
  }

  const first = loaded[0].base;
  const canvas = document.createElement('canvas');
  canvas.width = first.naturalWidth;
  canvas.height = first.naturalHeight;
  const ctx = canvas.getContext('2d');
  // Only the flat manufacturer-tint fallback needs a ratio - only reached for the one material
  // with no bespoke reskin at all (the Tediore_0_Starter placeholder), or if a layer's own real
  // art failed to load for some reason.
  const needsFallback = loaded.some((l) => !l.real);
  const tintRatio = needsFallback ? tintRatioFor(manuTok, materialId) : null;
  for (const layer of loaded) {
    let baseImg = layer.base;
    if (tintRatio && !layer.real) baseImg = recolorImg(baseImg, layer.base.src + '/' + (materialId || manuTok), tintRatio);
    ctx.drawImage(baseImg, 0, 0);
  }

  const trimmed = trimCanvas(canvas);
  img.src = trimmed.toDataURL('image/png');
  img.hidden = false;
  if (empty) empty.hidden = true;
  return true;
}
window.update2DViewerShield = update2DViewerShield;
