import * as THREE from './vendor/three/three.module.js';
import { GLTFLoader } from './vendor/three/addons/GLTFLoader.js';
import { OrbitControls } from './vendor/three/addons/OrbitControls.js';
import { EffectComposer } from './vendor/three/addons/postprocessing/EffectComposer.js';
import { RenderPass } from './vendor/three/addons/postprocessing/RenderPass.js';
import { SSAOPass } from './vendor/three/addons/postprocessing/SSAOPass.js';
import { OutputPass } from './vendor/three/addons/postprocessing/OutputPass.js';

// Which real game package (models/<pkg>/*.gltf, extracted from the player's own
// Borderlands 1 install with UModel) supplies this weapon type's visuals. Several
// UI weapon types are reskinned/rebalanced subtypes that share their parent type's
// meshes in-game (Support MG <- Combat Rifle, Assault Shotgun <- Combat Shotgun,
// Semi-Auto Sniper <- Sniper Rifle, Machine Pistol <- Repeater Pistol) - confirmed
// by there being no separate weap_*.upk for those four.
export const TYPE_PKG = {
  patrol_smg: 'weap_patrol_smg',
  revolver_pistol: 'weap_revolver_pistol',
  repeater_pistol: 'weap_repeater_pistol',
  machine_pistol: 'weap_repeater_pistol',
  combat_rifle: 'weap_combat_rifle',
  support_machinegun: 'weap_combat_rifle',
  combat_shotgun: 'weap_combat_shotgun',
  assault_shotgun: 'weap_combat_shotgun',
  sniper_rifle: 'weap_sniper_rifle',
  sniper_rifle_semiauto: 'weap_sniper_rifle',
  rocket_launcher: 'weap_rocket_launcher',
  eridian_cannon: 'weap_alien_rifle',
  eridian_blaster: 'weap_alien_rifle',
  eridian_thunderstorm: 'weap_alien_rifle',
  eridian_lightning: 'weap_alien_rifle',
  eridian_railgun: 'weap_alien_rifle',
};

const SLOTS = ['Body', 'Grip', 'mag', 'Barrel', 'Sight', 'Stock', 'Action', 'acc'];

// Old screenshot-sampled approximations, kept ONLY as a fallback source for manufacturers
// without a REAL_MATERIAL entry below. [primary, accentR, accentG, accentB]
export const MANUFACTURER_TINT = {
  Dahl:            ['#8a6b45', '#2e2418', '#8a6b45', '#c9a878'],
  Torgue:          ['#3a3a3e', '#18181a', '#3a3a3e', '#55565c'],
  Maliwan:         ['#0033ff', '#1c1c22', '#8fb0e0', '#c8daf0'],
  Hyperion:        ['#6e1f28', '#1a1214', '#6e1f28', '#9c3038'],
  tediore:         ['#c8ccd0', '#6a6e74', '#c8ccd0', '#dfe2e5'],
  Vladof:          ['#3a3632', '#c9722e', '#3a3632', '#5a5450'],
  Atlas:           ['#d0d5da', '#7a828c', '#d0d5da', '#e8ebef'],
  Jakobs:          ['#a8763a', '#3a2410', '#a8763a', '#d9a855'],
  SandSMunitions:  ['#1c1c1c', '#e8d820', '#1c1c1c', '#3a3a3a'],
  Gearbox:         ['#c07830', '#4a2e12', '#c07830', '#e0a050'],
};

// The REAL game shader (weap_materials_master.upk, MaterialInstanceConstant, read with
// umodel -dump) multiplies the base diffuse texture by one of these two color parameters,
// chosen per-pixel via the mesh's own mask texture (mask.png, already extracted) - not a
// hue/saturation replace, and not a hand-tuned shade-band approximation. metal_color turned
// out to be IDENTICAL across all 3 Maliwan quality tiers (a fixed baseline highlight tone);
// composite_color is the one that actually scales with tier (confirmed tier1/2/3 all
// differ) - it's the "how premium/how manufacturer-colored" channel. Values are stored
// pre-normalized by their own max channel (so a straight multiply doesn't blow out past 1).
// Only Maliwan is confirmed from real data so far; other manufacturers still render via the
// MANUFACTURER_TINT hex fallback until they get the same treatment.
export const REAL_MATERIAL = {
  Maliwan: { metal: [0.5, 0.6, 1.0], composite: [1 / 6, 2 / 6, 1.0] },
};

// Real per-material colors (not per-manufacturer averages), covering every generic
// manufacturer tier AND essentially every named unique/legendary/pearlescent weapon's own
// bespoke skin. Same UModel -dump methodology, applied to every MaterialInstanceConstant in
// the game's own weap_materials_master.upk and DLC3's dlc3_weap_materials.upk (75 of the
// game's 86 real material parts - the rest are Eridian (no material system), Kyros' Power
// (genuinely couldn't find a bespoke asset for it), the four zero-rarity promo/pre-order
// weapons (GameStop/BestBuy/IGN/GameSpy - never had bespoke art in the first place), and 3
// materials whose real params use a shader trick (negative color multiply) a flat tint can't
// represent - all of those still fall back to MANUFACTURER_TINT below). Keyed by the exact
// material pid gearData.json itself uses, so a lookup here needs no manufacturer-token
// indirection at all - see materialManuToken()/tintManuTok in index.html for why that
// indirection exists as the fallback path for everything not covered here.
export const REAL_MATERIAL_BY_PID = {
  "AjaxSpear_Material": { metal: [0.8333, 0.8333, 1.0], composite: [1.0, 0.4, 0.0] },
  "AthenasWisdom_Material": { metal: [0.25, 0.0, 1.0], composite: [1.0, 0.02, 0.4] },
  "Blister_Material": { metal: [0.0, 0.2, 1.0], composite: [0.7717, 1.0, 0.936] },
  "BoneShredder_Material": { metal: [1.0, 0.0, 0.0], composite: [1.0, 1.0, 0.9] },
  "BoomStick_Material": { metal: [0.6, 0.6, 1.0], composite: [0.0, 0.5, 1.0] },
  "DahlJackal_Material": { metal: [1.0, 0.0, 0.0], composite: [0.8, 1.0, 0.0] },
  "DahlTyphoon_Material": { metal: [0.5, 0.25, 1.0], composite: [0.25, 0.75, 1.0] },
  "JakobsBessie_Material": { metal: [0.0, 0.0, 0.0], composite: [1.0, 0.3913, 0.1304] },
  "KnoxsGold_Material": { metal: [1.0, 0.5, 0.0], composite: [1.0, 0.4, 0.0] },
  "KromsSidearm_Material": { metal: [1.0, 1.0, 0.4], composite: [1.0, 1.0, 0.4] },
  "LadyFinger_Material": { metal: [1.0, 1.0, 1.0], composite: [1.0, 0.05, 0.25] },
  "Leviathan_Material": { metal: [0.8, 0.8, 1.0], composite: [0.25, 1.0, 0.25] },
  "MadJack_Material": { metal: [0.125, 0.15, 1.0], composite: [0.0, 1.0, 0.8] },
  "MaliwanTsunami_Material": { metal: [0.5, 1.0, 0.75], composite: [0.1667, 0.3333, 1.0] },
  "Material_Anshin_1": { metal: [0.2, 1.0, 1.0], composite: [1.0, 1.0, 1.0] },
  "Material_Aries_3": { metal: [0.25, 0.25, 1.0], composite: [0.8824, 0.9412, 1.0] },
  "Material_Atlas_1": { metal: [1.0, 1.0, 1.0], composite: [1.0, 1.0, 1.0] },
  "Material_Atlas_2": { metal: [0.875, 0.925, 1.0], composite: [0.8462, 0.9231, 1.0] },
  "Material_Atlas_3": { metal: [0.0, 0.0, 0.0], composite: [0.8824, 0.9412, 1.0] },
  "Material_Atlas_3_AjaxSpear": { metal: [0.8333, 0.8333, 1.0], composite: [1.0, 0.4, 0.0] },
  "Material_ChiquitoAmigo_3": { metal: [0.4, 1.0, 0.4], composite: [1.0, 0.9667, 0.8667] },
  "Material_Corraza_1": { metal: [0.6667, 0.6667, 1.0], composite: [1.0, 0.25, 0.3] },
  "Material_Dahl_0_starter": { metal: [1.0, 0.75, 0.5], composite: [0.5, 1.0, 0.4] },
  "Material_Dahl_1": { metal: [1.0, 0.75, 0.5], composite: [0.3333, 1.0, 0.125] },
  "Material_Dahl_2": { metal: [1.0, 0.9, 0.8], composite: [0.9, 0.9, 1.0] },
  "Material_Dahl_3": { metal: [1.0, 0.9, 0.8], composite: [1.0, 0.5, 0.2143] },
  "Material_Gearbox_1": { metal: [0.8, 0.92, 1.0], composite: [0.25, 1.0, 0.0] },
  "Material_Gearbox_2": { metal: [1.0, 0.5, 0.0], composite: [1.0, 0.1875, 0.25] },
  "Material_Gearbox_3": { metal: [1.0, 0.5, 0.0], composite: [1.0, 0.2, 0.0] },
  "Material_Hyperion_0_starter": { metal: [1.0, 0.8, 0.5], composite: [1.0, 0.0769, 0.0769] },
  "Material_Hyperion_1": { metal: [1.0, 0.0, 0.0], composite: [1.0, 0.0769, 0.0769] },
  "Material_Hyperion_2": { metal: [1.0, 0.0, 0.0], composite: [0.8235, 0.8235, 1.0] },
  "Material_Jakobs_0_starter": { metal: [1.0, 0.8, 0.8], composite: [1.0, 0.625, 0.25] },
  "Material_Jakobs_1": { metal: [1.0, 0.8, 0.6], composite: [1.0, 0.2182, 0.0909] },
  "Material_Jakobs_2": { metal: [0.9, 0.9, 1.0], composite: [1.0, 0.5, 0.25] },
  "Material_Jakobs_3": { metal: [1.0, 0.5, 0.0], composite: [1.0, 0.2182, 0.0909] },
  "Material_Maliwan_0_starter": { metal: [0.8333, 0.9167, 1.0], composite: [1.0, 1.0, 0.8333] },
  "Material_Maliwan_1": { metal: [0.5, 0.6, 1.0], composite: [1.0, 1.0, 0.8333] },
  "Material_Maliwan_2": { metal: [0.5, 0.6, 1.0], composite: [0.5, 1.0, 1.0] },
  "Material_Maliwan_3": { metal: [0.5, 0.6, 1.0], composite: [0.1667, 0.3333, 1.0] },
  "Material_Pangolin_1": { metal: [1.0, 0.5, 0.0], composite: [0.8125, 1.0, 0.25] },
  "Material_SandS_0_starter": { metal: [1.0, 0.75, 0.125], composite: [1.0, 0.6667, 0.0] },
  "Material_SandS_1": { metal: [1.0, 0.75, 0.0], composite: [1.0, 1.0, 1.0] },
  "Material_SandS_2": { metal: [1.0, 0.75, 0.125], composite: [1.0, 0.1667, 0.0] },
  "Material_SandS_3": { metal: [1.0, 0.8, 0.0], composite: [1.0, 1.0, 0.0] },
  "Material_Stock": { metal: [1.0, 1.0, 1.0], composite: [1.0, 1.0, 1.0] },
  "Material_Tediore_1": { metal: [1.0, 1.0, 1.0], composite: [1.0, 0.9333, 0.7667] },
  "Material_Tediore_2": { metal: [1.0, 1.0, 1.0], composite: [1.0, 0.9667, 0.8667] },
  "Material_Tediore_3": { metal: [1.0, 1.0, 1.0], composite: [1.0, 0.95, 0.8] },
  "Material_TheChopper_3": { metal: [1.0, 0.0, 0.0], composite: [1.0, 0.0833, 0.0] },
  "Material_Torgue_0_starter": { metal: [0.75, 0.75, 1.0], composite: [1.0, 0.8571, 0.7143] },
  "Material_Torgue_1": { metal: [0.6, 0.6, 1.0], composite: [1.0, 1.0, 0.75] },
  "Material_Torgue_2": { metal: [0.6, 0.6, 1.0], composite: [0.8333, 0.9, 1.0] },
  "Material_Torgue_3": { metal: [0.6, 0.6, 1.0], composite: [0.75, 0.75, 1.0] },
  "Material_Vladof_0_starter": { metal: [0.8333, 0.8333, 1.0], composite: [1.0, 0.1667, 0.0] },
  "Material_Vladof_1": { metal: [1.0, 0.8, 0.8], composite: [1.0, 0.2333, 0.0] },
  "Material_Vladof_2": { metal: [0.85, 0.9, 1.0], composite: [1.0, 0.3, 0.0] },
  "Material_Vladof_3": { metal: [0.0, 0.0, 0.0], composite: [1.0, 0.25, 0.0] },
  "Nailer_Material": { metal: [0.0, 0.0, 0.0], composite: [1.0, 0.0, 0.0] },
  "Patton_Material": { metal: [0.6667, 0.6667, 1.0], composite: [1.0, 1.0, 1.0] },
  "ReaversEdge_Material": { metal: [1.0, 0.6667, 0.0], composite: [1.0, 0.2857, 0.0] },
  "SandSSerpens_Material": { metal: [1.0, 0.75, 0.125], composite: [0.0, 1.0, 0.0] },
  "Sentinel_Material": { metal: [0.0, 0.0, 0.0], composite: [1.0, 0.02, 0.02] },
  "SledgesShotgun_Material": { metal: [1.0, 0.125, 0.0], composite: [1.0, 0.75, 0.5] },
  "TKsWave_Material": { metal: [0.5714, 1.0, 0.8571], composite: [0.0, 0.5, 1.0] },
  "TedioreAvenger_Material": { metal: [1.0, 0.65, 0.5], composite: [1.0, 0.875, 0.5] },
  "TheBigToe_Material": { metal: [1.0, 1.0, 1.0], composite: [1.0, 0.9375, 0.3125] },
  "TheClipper_Material": { metal: [0.875, 0.875, 1.0], composite: [1.0, 0.0833, 0.0] },
  "TheDove_Material": { metal: [0.4444, 0.4444, 1.0], composite: [1.0, 1.0, 1.0] },
  "TheMeatGrinder_Material": { metal: [1.0, 0.75, 1.0], composite: [1.0, 0.5, 0.5] },
  "TheRoaster_Material": { metal: [0.5, 1.0, 1.0], composite: [0.7143, 0.8571, 1.0] },
  "TheSpy_Material": { metal: [1.0, 1.0, 1.0], composite: [1.0, 0.2, 0.2] },
  "TorgueUndertaker_Material": { metal: [0.0, 0.0, 0.0], composite: [1.0, 0.8333, 0.8333] },
  "VladofRevenge_Material": { metal: [0.0, 0.0, 0.0], composite: [1.0, 0.25, 0.0] },
  "VladofStalker_Material": { metal: [1.0, 0.0, 0.0], composite: [1.0, 0.0833, 0.0] },
};

const SLOT_MESH_PREFIX = { Body: 'body', Grip: 'grip', mag: 'mag', Barrel: 'barrel', Sight: 'sight', Stock: 'stock', Action: 'action', acc: 'acc' };

// Most part ids are "<prefix><n>_SomeName" (e.g. "mag1_thumper"), but some named/unique
// parts put the name FIRST (e.g. "BoneShredder_mag5") - so search for the slot's own
// prefix+digit anywhere in the id rather than assuming it's a leading match. An explicit
// "no part" selection ("acc_none", "sight_none", ...) has no mesh at all - skip it rather
// than requesting a file that was never going to exist.
function meshBaseName(slot, partId) {
  if (!partId || /none/i.test(partId)) return null;
  const prefix = SLOT_MESH_PREFIX[slot];
  if (prefix) {
    const m = new RegExp(prefix + '([0-9]+)', 'i').exec(partId);
    if (m) return prefix + m[1];
  }
  const g = /^([a-zA-Z]+[0-9]+)/.exec(partId);
  return g ? g[1] : null;
}

const texCache = new Map();   // "pkg/file" -> Promise<Texture|null>
const matCache = new Map();   // "pkg/manuTok" -> Material
// Materials created here are cached and reused across every rebuild - never dispose
// one of these when clearing old parts out of a group, only the per-load geometry.
const sharedMaterials = new Set();

function loadTexture(pkg, file, srgb) {
  const key = pkg + '/' + file;
  if (texCache.has(key)) return texCache.get(key);
  const p = new Promise((resolve) => {
    new THREE.TextureLoader().load(
      `models/${pkg}/${file}`,
      // Repeat, not the default clamp: many parts' UVs run past 1.0 (up to ~2.4 on the Patrol SMG)
      // because the game tiles its texture atlas - clamping smeared the edge pixel over those
      // areas as a flat gray patch.
      (tex) => { tex.flipY = false; tex.wrapS = tex.wrapT = THREE.RepeatWrapping; if (srgb) tex.colorSpace = THREE.SRGBColorSpace; resolve(tex); },
      undefined,
      () => resolve(null)
    );
  });
  texCache.set(key, p);
  return p;
}

// Deliberately NOT cached across callers: a loaded glTF scene graph can only live in one
// place at a time (one parent), and we have two independent consumers (the static snapshot
// and the live 3D View tab). The network fetch itself is still cheap the second time
// (browser HTTP cache), so reloading per-consumer is simple and avoids SkinnedMesh clone bugs.
function loadPart(pkg, base) {
  return new Promise((resolve) => {
    new GLTFLoader().load(
      `models/${pkg}/${base}.gltf`,
      (gltf) => resolve(gltf.scene),
      undefined,
      () => resolve(null)
    );
  });
}

const plainMatCache = new Map(); // pkg -> Promise<Material>

// Untinted material for parts whose own texture is already the correct final color (the
// accessory's elemental glow) - no manufacturer tint, no brighten, just the real art as
// authored, so a red Explosive glow stays red regardless of who makes the weapon.
function getPlainMaterial(pkg) {
  if (plainMatCache.has(pkg)) return plainMatCache.get(pkg);
  const p = loadTexture(pkg, 'color.png', true).then((tex) => {
    const mat = new THREE.MeshBasicMaterial({ map: tex || null, color: tex ? 0xffffff : 0x9a9a9a });
    sharedMaterials.add(mat);
    return mat;
  });
  plainMatCache.set(pkg, p);
  return p;
}

// ---- The game-styled look ------------------------------------------------------------------
// Borderlands' own weapon material (mat_weapons_1, read from the game with UModel) uses more than
// the color + mask images the viewer used to: a normal map (surface bumps), a "lightness" image
// (hand-painted panel lines/edge wear: green channel for the metal areas, blue for the composite
// areas, red = the parts that glow), and separate highlight sharpness for metal (power 4),
// composite (10) and constant (16) areas, on top of the cel-shaded ("toon") lighting and dark ink
// outlines the game is known for. This reproduces that with a lit, banded shader plus an outline
// pass. The real tint colors (REAL_MATERIAL_BY_PID) still pick the base color exactly as before.
// Same element colors the 2D card uses (ELEMENTS in index.html), keyed by the accessory's own name.
const ELEMENT_COLOR = { Incendiary: '#FF2E2E', Corrosive: '#64FF73', Shock: '#817BFF', Explosive: '#FFFFBF' };
const NORMAL_Y = -1; // Unreal's normal maps have the green channel flipped relative to glTF/Three.js

// Tuning values for the look, shared by every game-styled material.
const gameParams = {
  shadeBase: { value: 0.36 }, shadeKey: { value: 0.5 }, shadeFill: { value: 0.1 },
  detailBase: { value: 0.6 }, detailGain: { value: 1.2 },
  specGain: { value: 0.28 }, rimGain: { value: 0.045 }, glowGain: { value: 1.3 }, saturation: { value: 1.25 },
};

const GAME_SHADER_HEADER = `
uniform float shadeBase; uniform float shadeKey; uniform float shadeFill;
uniform float detailBase; uniform float detailGain;
uniform float specGain; uniform float rimGain; uniform float glowGain; uniform float saturation;
uniform sampler2D maskMap;
uniform sampler2D lightMap;
uniform float useReal;
uniform float preserveBaked;
uniform vec3 elemColor;
uniform float elemAmt;
uniform vec3 metalTint;
uniform vec3 compositeTint;
uniform vec3 tint1;
uniform vec3 tint2;
uniform vec3 tint3;
// Lighting comes in three flat bands (shadow / mid / lit) with a soft edge, like the game's cel shading.
float toonRamp( float x ) {
  float a = smoothstep( 0.02, 0.14, x );
  float b = smoothstep( 0.42, 0.58, x );
  return 0.45 * a + 0.55 * b;
}
`;

// Base color: identical to the tint math the flat viewer used (so colors stay matched to the
// game's own material colors), just moved into the lit shader.
const GAME_ALBEDO_GLSL = `#include <map_fragment>
float gBaked = 0.0;
vec3 gBakedCol = vec3( 0.0 );
{
  // Accessories carry their element glow as strongly colored spots baked into the base image
  // (the rest of it is plain gray). Those spots keep their true color instead of being tinted.
  vec3 raw = diffuseColor.rgb;
  float rawSat = max( max( raw.r, raw.g ), raw.b ) - min( min( raw.r, raw.g ), raw.b );
  gBaked = preserveBaked * smoothstep( mix( 0.14, 0.05, elemAmt ), mix( 0.24, 0.10, elemAmt ), rawSat );
  // The image bakes ONE glow color per accessory mesh; the game recolors it per element, so when
  // the equipped accessory is an element (Corrosive, Incendiary, ...) swap in that element's color,
  // keeping the baked spot's own brightness pattern.
  float rawLum = dot( raw, vec3( 0.299, 0.587, 0.114 ) );
  gBakedCol = mix( raw, elemColor * ( 0.5 + 0.9 * rawLum ), elemAmt );
  vec3 m = texture2D( maskMap, vMapUv ).rgb;
  float lum = dot( diffuseColor.rgb, vec3( 0.299, 0.587, 0.114 ) );
  vec3 natural = mix( diffuseColor.rgb, vec3( lum ), 0.75 ) * 0.55;
  if ( useReal > 0.5 ) {
    const float PRE_BRIGHTEN = 1.9;
    float coverage = clamp( m.r + m.g, 0.0, 1.0 );
    vec3 tint = mix( metalTint, compositeTint, m.r / max( m.r + m.g, 0.0001 ) );
    vec3 brightened = min( diffuseColor.rgb * PRE_BRIGHTEN, vec3( 1.0 ) );
    diffuseColor.rgb = mix( natural, brightened * tint, coverage );
  } else {
    float mCoverage = clamp( m.r + m.g + m.b, 0.0, 1.0 );
    vec3 accent = ( tint1 * m.r + tint2 * m.g + tint3 * m.b ) / max( mCoverage, 0.0001 );
    diffuseColor.rgb = mix( natural, accent * ( 0.8 + 0.35 * lum ), mCoverage );
  }
}`;

// Replaces the stock toon material's final light sum with our own shading. Uses the (normal-mapped)
// surface normal `normal` and `vViewPosition` the stock shader already computed.
const GAME_LIGHTING_GLSL = `
vec3 outgoingLight;
{
  vec3 m  = texture2D( maskMap, vMapUv ).rgb;
  vec3 lt = texture2D( lightMap, vMapUv ).rgb;
  float cov = clamp( m.r + m.g, 0.0, 1.0 );
  float detail = mix( lt.g, lt.b, m.r / max( m.r + m.g, 0.0001 ) );
  detail = mix( lt.g, detail, cov );
  vec3 albedo = diffuseColor.rgb * clamp( detailBase + detailGain * detail, 0.0, 2.2 );
  float albedoLum = dot( albedo, vec3( 0.299, 0.587, 0.114 ) );
  albedo = max( mix( vec3( albedoLum ), albedo, saturation ), vec3( 0.0 ) );

  vec3 N = normalize( normal );
  vec3 V = normalize( vViewPosition );
  vec3 L1 = normalize( vec3( -0.45, 0.70, 0.62 ) );
  vec3 L2 = normalize( vec3( 0.75, -0.15, 0.45 ) );
  float shade = shadeBase + shadeKey * toonRamp( dot( N, L1 ) ) + shadeFill * toonRamp( dot( N, L2 ) );
  vec3 col = albedo * shade;

  vec3 H = normalize( L1 + V );
  float nh = max( dot( N, H ), 0.0 );
  float spec = m.g * pow( nh, 6.0 ) * 0.55 + m.r * pow( nh, 12.0 ) * 0.7 + m.b * pow( nh, 16.0 ) * 0.8;
  spec *= ( 0.4 + 1.6 * detail );
  spec = smoothstep( 0.18, 0.32, spec ) * 0.55 + spec * 0.25;
  col += vec3( 1.0, 0.97, 0.9 ) * spec * specGain;

  float rim = pow( 1.0 - max( dot( N, V ), 0.0 ), 3.0 );
  col += vec3( 0.55, 0.65, 0.8 ) * rim * rimGain;

  // Glowing parts: the game's default glow color is blue, but an elemental accessory glows in its element's color.
  col += mix( vec3( 0.2, 0.2, 1.0 ), elemColor, elemAmt ) * lt.r * glowGain;
  col = mix( col, gBakedCol * 1.3, gBaked );
  outgoingLight = col;
}`;

function makeGameMaterial(tex, maskTex, lightTex, normTex, real, tint, forAcc) {
  for (const t of [maskTex, lightTex, normTex]) t.colorSpace = THREE.NoColorSpace;
  const mat = new THREE.MeshToonMaterial({ map: tex || null, color: tex ? 0xffffff : 0x9a9a9a, normalMap: normTex });
  mat.normalScale.set(1, NORMAL_Y);
  mat.userData.elem = { color: { value: new THREE.Color(1, 1, 1) }, amt: { value: 0 } }; // set per build for accessories
  const fb = tint ? tint.map((h) => new THREE.Color(h)) : [new THREE.Color(1, 1, 1), new THREE.Color(1, 1, 1), new THREE.Color(1, 1, 1), new THREE.Color(1, 1, 1)];
  mat.onBeforeCompile = (shader) => {
    Object.assign(shader.uniforms, gameParams);
    shader.uniforms.maskMap = { value: maskTex };
    shader.uniforms.lightMap = { value: lightTex };
    shader.uniforms.useReal = { value: real ? 1 : 0 };
    shader.uniforms.preserveBaked = { value: forAcc ? 1 : 0 };
    shader.uniforms.elemColor = mat.userData.elem.color;
    shader.uniforms.elemAmt = mat.userData.elem.amt;
    shader.uniforms.metalTint = { value: new THREE.Vector3(...(real ? real.metal : [1, 1, 1])) };
    shader.uniforms.compositeTint = { value: new THREE.Vector3(...(real ? real.composite : [1, 1, 1])) };
    shader.uniforms.tint1 = { value: fb[1] };
    shader.uniforms.tint2 = { value: fb[2] };
    shader.uniforms.tint3 = { value: fb[3] };
    shader.fragmentShader = GAME_SHADER_HEADER + shader.fragmentShader;
    shader.fragmentShader = shader.fragmentShader.replace('#include <map_fragment>', GAME_ALBEDO_GLSL);
    shader.fragmentShader = shader.fragmentShader.replace(
      'vec3 outgoingLight = reflectedLight.directDiffuse + reflectedLight.indirectDiffuse + totalEmissiveRadiance;',
      GAME_LIGHTING_GLSL
    );
  };
  mat.customProgramCacheKey = () => 'gamemat';
  return mat;
}

// Dark ink outline: every part is drawn a second time, back faces only, pushed outward along its
// normals by a fixed number of screen pixels. Skinned-mesh aware (the game's parts are skinned).
let outlineMaterial = null;
function getOutlineMaterial() {
  if (outlineMaterial) return outlineMaterial;
  outlineMaterial = new THREE.ShaderMaterial({
    side: THREE.BackSide,
    uniforms: { thickness: { value: 0.0085 } },
    vertexShader: `
      #include <common>
      #include <skinning_pars_vertex>
      uniform float thickness;
      void main() {
        #include <skinbase_vertex>
        #include <beginnormal_vertex>
        #include <skinnormal_vertex>
        #include <begin_vertex>
        #include <skinning_vertex>
        vec4 clipPos = projectionMatrix * modelViewMatrix * vec4( transformed, 1.0 );
        vec3 nView = normalize( normalMatrix * objectNormal );
        vec2 dir = normalize( ( projectionMatrix * vec4( nView, 0.0 ) ).xy + vec2( 1e-5 ) );
        dir.x *= projectionMatrix[0][0] / projectionMatrix[1][1];
        clipPos.xy += dir * thickness * clipPos.w;
        gl_Position = clipPos;
      }`,
    fragmentShader: `void main() { gl_FragColor = vec4( 0.035, 0.025, 0.02, 1.0 ); }`,
  });
  sharedMaterials.add(outlineMaterial);
  return outlineMaterial;
}

function addOutline(mesh) {
  const hull = mesh.isSkinnedMesh
    ? new THREE.SkinnedMesh(mesh.geometry, getOutlineMaterial())
    : new THREE.Mesh(mesh.geometry, getOutlineMaterial());
  if (mesh.isSkinnedMesh) hull.bind(mesh.skeleton, mesh.bindMatrix);
  hull.frustumCulled = false;
  hull.userData.isOutline = true;
  mesh.add(hull);
}

async function getMaterial(pkg, manuTok, materialId, forAcc) {
  const key = pkg + '/' + (materialId || manuTok || '') + (forAcc ? '/acc' : '');
  if (matCache.has(key)) return matCache.get(key);
  const [tex, maskTex, lightTex, normTex] = await Promise.all([
    loadTexture(pkg, 'color.png', true),
    loadTexture(pkg, 'mask.png', false),
    loadTexture(pkg, 'light.png', false),
    loadTexture(pkg, 'norm.png', false),
  ]);
  const real = REAL_MATERIAL_BY_PID[materialId] || REAL_MATERIAL[manuTok];
  const tint = MANUFACTURER_TINT[manuTok];
  // Every weapon type except the Eridian rifle ships the game's own painted-detail and surface-bump
  // images, so they get the full game-styled shader; anything else falls through to the flat one below.
  if (maskTex && lightTex && normTex && (real || tint)) {
    const gm = makeGameMaterial(tex, maskTex, lightTex, normTex, real, tint, forAcc);
    sharedMaterials.add(gm);
    matCache.set(key, gm);
    return gm;
  }
  // Unlit on purpose: MeshStandardMaterial's PBR lighting response (soft gradients,
  // specular highlights, roughness/metalness reflections) is exactly what makes a render
  // read as "a 3D render" instead of a flat game icon, no matter how the color itself is
  // tuned. MeshBasicMaterial applies zero dynamic lighting, so only this shader's own flat
  // tint (plus the mild baked-texture shading it already does) ends up on screen.
  const mat = new THREE.MeshBasicMaterial({ map: tex || null, color: tex ? 0xffffff : 0x9a9a9a });
  sharedMaterials.add(mat);
  if (maskTex && real) {
    // The REAL shader technique: multiply the base texture by metal_color or
    // composite_color, chosen per-pixel via the mask - not a hue/sat replace or a
    // hand-tuned shade band. Mask G channel = metal (the fixed baseline highlight),
    // R channel = composite (the tier-varying "how manufacturer-colored" tone) - matches
    // this mesh's own mask being green-dominant almost everywhere (confirmed by
    // rendering the raw channels), i.e. mostly the fixed metal tone with composite as
    // the rarer accent. PRE_BRIGHTEN compensates for the base texture reading darker
    // than the real target brightness, same fix validated for the flat 2D sprites.
    maskTex.colorSpace = THREE.NoColorSpace;
    mat.onBeforeCompile = (shader) => {
      shader.uniforms.maskMap = { value: maskTex };
      shader.uniforms.metalTint = { value: new THREE.Vector3(...real.metal) };
      shader.uniforms.compositeTint = { value: new THREE.Vector3(...real.composite) };
      shader.fragmentShader = 'uniform sampler2D maskMap;\nuniform vec3 metalTint;\nuniform vec3 compositeTint;\n' + shader.fragmentShader;
      shader.fragmentShader = shader.fragmentShader.replace(
        '#include <map_fragment>',
        `#include <map_fragment>
        {
          const float PRE_BRIGHTEN = 1.9;
          vec3 m = texture2D( maskMap, vMapUv ).rgb;
          float coverage = clamp(m.r + m.g, 0.0, 1.0);
          vec3 tint = mix(metalTint, compositeTint, m.r / max(m.r + m.g, 0.0001));
          vec3 brightened = min(diffuseColor.rgb * PRE_BRIGHTEN, vec3(1.0));
          // Unmasked areas (grip/trigger guard) aren't perfectly neutral grey in the raw
          // texture - brightening them as-is amplified a faint stray tint into a visibly
          // wrong color (pink). Desaturate toward the pixel's own luminance there instead,
          // so it reads as neutral dark metal/plastic regardless of the raw texture color.
          float lum = dot(diffuseColor.rgb, vec3(0.299, 0.587, 0.114));
          // Darken here, don't brighten - PRE_BRIGHTEN is specifically compensating for
          // the tinted regions reading darker than the real target, it doesn't apply to
          // the grip, which is supposed to stay dark/neutral plastic.
          vec3 natural = mix(diffuseColor.rgb, vec3(lum), 0.75) * 0.55;
          diffuseColor.rgb = mix(natural, brightened * tint, coverage);
        }`
      );
      mat.userData.shader = shader;
    };
    mat.customProgramCacheKey = () => 'realtint_' + pkg + '_' + (materialId || manuTok);
  } else if (maskTex && tint) {
    maskTex.colorSpace = THREE.NoColorSpace;
    const c0 = new THREE.Color(tint[0]), c1 = new THREE.Color(tint[1]), c2 = new THREE.Color(tint[2]), c3 = new THREE.Color(tint[3]);
    mat.onBeforeCompile = (shader) => {
      shader.uniforms.maskMap = { value: maskTex };
      shader.uniforms.primaryTint = { value: c0 };
      shader.uniforms.tint1 = { value: c1 };
      shader.uniforms.tint2 = { value: c2 };
      shader.uniforms.tint3 = { value: c3 };
      shader.fragmentShader = 'uniform sampler2D maskMap;\nuniform vec3 primaryTint;\nuniform vec3 tint1;\nuniform vec3 tint2;\nuniform vec3 tint3;\n' + shader.fragmentShader;
      shader.fragmentShader = shader.fragmentShader.replace(
        '#include <map_fragment>',
        `#include <map_fragment>
        {
          // Tint colors are treated as the target flat color almost outright (a mild
          // +-25% shade band from the texture's own light/shadow detail, not a full
          // multiply) - a straight multiply against the grey base texture plus this
          // scene's own lighting compounds into mud far darker than intended.
          // Areas the mask leaves untouched (grip/trigger guard on this build) are, by the
          // game's own design, neutral dark plastic/metal that never takes manufacturer
          // color at all - forcing a tint wash onto them (the old "primary applies
          // everywhere" approach) is what turned them the wrong color. So: only tint where
          // the mask actually has coverage: elsewhere, just brighten the real base texture.
          vec3 m = texture2D( maskMap, vMapUv ).rgb;
          float mCoverage = clamp(m.r + m.g + m.b, 0.0, 1.0);
          vec3 accent = (tint1 * m.r + tint2 * m.g + tint3 * m.b) / max(mCoverage, 0.0001);
          float lum = dot(diffuseColor.rgb, vec3(0.299, 0.587, 0.114));
          // Unmasked areas (grip/trigger guard) turned out to have real, sometimes
          // colorful, detail baked into the base texture (not neutral grey) - brightening
          // it as-is just made stray color blotches more visible. Desaturate hard toward
          // its own luminance and darken instead, so it reads as neutral dark metal/plastic
          // regardless of what the raw texture pixel actually is.
          vec3 natural = mix(diffuseColor.rgb, vec3(lum), 0.75) * 0.55;
          diffuseColor.rgb = mix(natural, accent * (0.8 + 0.35 * lum), mCoverage);
        }`
      );
      mat.userData.shader = shader;
    };
    mat.customProgramCacheKey = () => 'tint_' + pkg + '_' + manuTok;
  }
  matCache.set(key, mat);
  return mat;
}

// Each part swap loads a fresh, uncached glTF (see loadPart's note above) - the old
// geometry it replaces has no other owner, and Three.js won't free its GPU buffers on
// its own just because the JS object becomes unreferenced. Without this, swapping parts
// repeatedly (which is most of what this app does) leaks GPU memory forever. Materials
// are excluded: they come from the caches above and stay in use by future rebuilds.
function disposeObject3D(root) {
  root.traverse((o) => {
    if (!o.isMesh) return;
    o.geometry?.dispose();
    const mats = Array.isArray(o.material) ? o.material : [o.material];
    for (const m of mats) if (m && !sharedMaterials.has(m)) m.dispose();
  });
}

async function assembleParts(pkg, sel, manuTok, materialId, group) {
  const [mat, plainMat, accMat] = await Promise.all([
    getMaterial(pkg, manuTok, materialId),
    getPlainMaterial(pkg),
    getMaterial(pkg, manuTok, materialId, true),
  ]);
  if (accMat.userData && accMat.userData.elem) {
    const accP = sel.acc && sel.acc.p;   // the element the accessory really fires (data), else the old name check
    const accName = (accP && accP.elem && accP.elem[0]) || (accP && accP.pn);
    const hex = ELEMENT_COLOR[accName];
    if (hex) accMat.userData.elem.color.value.set(hex);
    accMat.userData.elem.amt.value = hex ? 1 : 0;
  }
  const loaded = await Promise.all(SLOTS.map(async (slot) => {
    const s = sel[slot];
    if (!s || !s.id) return null;
    const base = meshBaseName(slot, s.id);
    if (!base) return null;
    return loadPart(pkg, base);
  }));
  while (group.children.length) {
    const child = group.children[0];
    disposeObject3D(child);
    group.remove(child);
  }
  let any = false;
  loaded.forEach((obj, i) => {
    if (!obj) return;
    // The accessory's own texture already has its element glow baked in (e.g. red for
    // Explosive) - it's not manufacturer-colored in the real game, so running it through
    // the manufacturer tint shader was shifting that real color (red -> yellow). Leave it
    // on the plain, untinted material instead.
    // Weapon types with the game's full material data shade the accessory like the rest of the gun
    // (its baked element-color spots are preserved inside that shader); others (the Eridian rifle)
    // keep the plain, untinted material.
    const slotMat = SLOTS[i] === 'acc' ? (accMat.isMeshToonMaterial ? accMat : plainMat) : mat;
    // Collect first: adding the outline meshes while traversing would make the traversal visit them.
    const meshes = [];
    obj.traverse((o) => { if (o.isMesh && !o.userData.isOutline) meshes.push(o); });
    for (const o of meshes) {
      o.material = slotMat;
      if (slotMat.isMeshToonMaterial) addOutline(o); // the game-styled shader gets the ink outline too
    }
    group.add(obj);
    any = true;
  });
  return any;
}

function frameCamera(camera, group, controls, sideOn) {
  // group.position gets shifted below to re-center the model - reset it first, or a
  // second rebuild computes its box from the PREVIOUS call's already-shifted position
  // and compounds the offset further off-origin every time (which is exactly why a
  // rebuild after the first one used to render almost entirely out of frame).
  group.position.set(0, 0, 0);
  const box = new THREE.Box3().setFromObject(group);
  const center = box.getCenter(new THREE.Vector3());
  const size = box.getSize(new THREE.Vector3());
  group.position.sub(center);
  // Fit a sphere enclosing the whole bounding box (its half-diagonal) into both the
  // vertical AND horizontal FOV - a fixed "span * constant" guess (the old approach)
  // doesn't account for aspect ratio or camera FOV, so on a wide/short canvas a long
  // thin gun (dominated by X/Z, barely any Y) ends up rendered tiny with a lot of
  // wasted margin. Whichever axis is tighter (usually horizontal, for a gun) wins.
  const radius = Math.max(size.length() / 2, 0.03);
  const isOrtho = !!camera.isOrthographicCamera;
  let dist;
  if (isOrtho) {
    dist = radius * 3; // just needs to clear the model - apparent size comes from the frustum below, not distance
  } else {
    const vFov = THREE.MathUtils.degToRad(camera.fov);
    const hFov = 2 * Math.atan(Math.tan(vFov / 2) * camera.aspect);
    dist = Math.max(radius / Math.sin(vFov / 2), radius / Math.sin(hFov / 2)) * 1.08;
  }
  if (sideOn) {
    // The real in-game/DuncanFogg card icon is a flat side profile - not a 3/4 "product
    // shot" angle. Look straight down the model's thickness axis so the long barrel-to-
    // stock length reads left-to-right, the way the real icon looks. Every extracted mesh
    // (SMG, Revolver, Combat Rifle, Repeater/Machine Pistol) shares X as that thickness
    // axis - confirmed directly by rendering each candidate axis and comparing the actual
    // silhouette, not by trusting the bounding-box's smallest dimension (that heuristic
    // picked Y for Repeater Pistol and produced a broken vertical-sliver render; some
    // part's geometry evidently skews the raw box dimensions for that package, even
    // though X is still visually the right axis, same as everywhere else).
    const pos = new THREE.Vector3();
    // Negative side: matches the real in-game card icon, which shows the barrel pointing
    // left with the grip/stock on the right - the positive side had it backwards.
    pos.setComponent(0, -dist);
    camera.up.set(0, 1, 0);
    pos.y += dist * 0.1; // slight lift for a bit of depth
    camera.position.copy(pos);
  } else {
    camera.position.set(dist * 0.55, dist * 0.4, dist).setLength(dist);
  }
  if (isOrtho) {
    const aspect = camera.userData.aspect || 1;
    const margin = radius * 0.85; // tighter crop - fills more of the card viewport
    camera.left = -margin * aspect; camera.right = margin * aspect;
    camera.top = margin; camera.bottom = -margin;
    camera.near = 0.01;
    camera.far = dist * 4;
  } else {
    camera.near = dist * 0.01;
    camera.far = dist * 20;
  }
  camera.updateProjectionMatrix();
  // OrbitControls.update() normally does this lookAt implicitly (via its target), which
  // is the only reason the live viewer ever pointed at the model - the static snapshot
  // path has no controls at all, so without this the camera sits right next to the model
  // but keeps its default orientation, framing empty space instead of the gun.
  camera.lookAt(0, 0, 0);
  if (controls) { controls.target.set(0, 0, 0); controls.update(); }
}

function makeLights(scene) {
  // Bright, flat-ish "product shot" rig rather than moody single-key lighting - the real
  // in-game card icon reads as a crisp, evenly-lit sprite, not a dim 3D render with soft
  // falloff, so this leans toward over-lit/high-key with a rim light for silhouette pop.
  scene.add(new THREE.AmbientLight(0xffffff, 2.6));
  const key = new THREE.DirectionalLight(0xffffff, 3.2);
  key.position.set(2, 3, 2);
  scene.add(key);
  const fill = new THREE.DirectionalLight(0xcfe0ee, 1.8);
  fill.position.set(-2, -1, -1.5);
  scene.add(fill);
  const rim = new THREE.DirectionalLight(0xffffff, 2.0);
  rim.position.set(-1, 2, -3);
  scene.add(rim);
}

// ---- static picture (Card tab) - a single render call per parts change, no animation
// loop at all. This is deliberately NOT a live viewer: it's meant to read like the real
// in-game inventory card icon, which is a flat picture, not something you spin around. ----
let snap = null; // { scene, camera, renderer, group }

function ensureSnap() {
  if (snap) return snap;
  const w = 480, h = 300;
  const scene = new THREE.Scene();
  // Orthographic, not perspective: a perspective camera introduces vanishing-point
  // distortion (the far end of the barrel looks smaller than the near end) that no real
  // flat game icon has - orthographic keeps parallel lines parallel, which is what actually
  // reads as "flat icon" instead of "3D render viewed from an angle".
  const camera = new THREE.OrthographicCamera(-1, 1, 1, -1, 0.01, 100);
  camera.userData.aspect = w / h;
  const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true, preserveDrawingBuffer: true });
  renderer.setSize(w, h);
  makeLights(scene);
  const group = new THREE.Group();
  scene.add(group);
  snap = { scene, camera, renderer, group };
  return snap;
}

async function updateSnapshot(pkg, sel, manuTok, materialId, gen, skipCardImage) {
  const img = document.getElementById('v3d_img');
  const empty = document.getElementById('v3d_empty');
  if (!img) return;

  // The Card tab already has real 2D art for this type (sprite2d.js ran first) -
  // still assemble the group below so the "View in 3D" tab has something to show,
  // just don't clobber the card's <img> with a 3D snapshot.
  if (skipCardImage) {
    const { scene, camera, group } = ensureSnap();
    await assembleParts(pkg, sel, manuTok, materialId, group);
    return;
  }

  if (!pkg) {
    img.hidden = true;
    if (empty) { empty.hidden = false; empty.textContent = 'No 3D preview for this weapon type'; }
    return;
  }

  const { scene, camera, renderer, group } = ensureSnap();
  const any = await assembleParts(pkg, sel, manuTok, materialId, group);
  if (gen !== genCounter) return;
  if (!any) { img.hidden = true; if (empty) { empty.hidden = false; empty.textContent = 'No parts selected'; } return; }

  frameCamera(camera, group, null, true);
  renderer.render(scene, camera);
  img.src = renderer.domElement.toDataURL('image/png');
  img.hidden = false;
  if (empty) empty.hidden = true;
}

// ---- live interactive viewer (3D View tab) - persistent scene, continuous render loop,
// full orbit controls. Driven by setInterval rather than requestAnimationFrame: rAF can
// silently stall in some embedded/automated contexts until something forces a real paint,
// and a fixed-tick timer sidesteps that instead of chasing it indirectly. ----
let live = null; // { scene, camera, renderer, controls, group, container }
let liveTimer = null;
let livePkg = null, liveSel = null, liveManuTok = null, liveMaterialId = null;

function ensureLive(container) {
  if (live && live.container === container) {
    // Scene already built - just make sure the render loop (possibly paused by
    // pauseLiveViewer when the tab was left) is running again.
    if (!liveTimer) {
      liveTimer = setInterval(() => {
        live.controls.update();
        live.composer.render();
      }, 33);
    }
    return live;
  }
  const scene = new THREE.Scene();
  const camera = new THREE.PerspectiveCamera(35, Math.max(container.clientWidth, 1) / Math.max(container.clientHeight, 1), 0.01, 100);
  const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
  renderer.setPixelRatio(Math.min(devicePixelRatio || 1, 2));
  renderer.setSize(container.clientWidth, container.clientHeight);
  container.innerHTML = '';
  container.appendChild(renderer.domElement);

  const controls = new OrbitControls(camera, renderer.domElement);
  controls.enableDamping = true;
  controls.dampingFactor = 0.1;
  controls.autoRotate = true;
  controls.autoRotateSpeed = 3.2;
  controls.enablePan = false;
  controls.minDistance = 0.05;
  controls.maxDistance = 20;

  makeLights(scene);
  const group = new THREE.Group();
  scene.add(group);

  // Cheap fake ambient occlusion (darkens tight crevices - where the barrel meets the
  // receiver, around screws/seams) - the toon shader above has no concept of this on its
  // own (just 2 fixed lights + a flat color), which was part of why the render read flatter/
  // more "cartoony" than intended. Tuned small: our models are a few units across (see the
  // OrbitControls min/max distance above), far smaller than SSAOPass's real-world-meter
  // defaults, so radius/min/maxDistance are all scaled way down from stock.
  const composer = new EffectComposer(renderer);
  composer.addPass(new RenderPass(scene, camera));
  const ssaoPass = new SSAOPass(scene, camera, container.clientWidth, container.clientHeight);
  ssaoPass.kernelRadius = 0.15;
  ssaoPass.minDistance = 0.0005;
  ssaoPass.maxDistance = 0.03;
  composer.addPass(ssaoPass);
  composer.addPass(new OutputPass());

  new ResizeObserver(() => {
    if (!container.clientWidth || !container.clientHeight) return;
    camera.aspect = container.clientWidth / container.clientHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(container.clientWidth, container.clientHeight);
    composer.setSize(container.clientWidth, container.clientHeight);
    ssaoPass.setSize(container.clientWidth, container.clientHeight);
  }).observe(container);

  live = { scene, camera, renderer, controls, group, container, composer };

  if (liveTimer) clearInterval(liveTimer);
  liveTimer = setInterval(() => {
    controls.update();
    composer.render();
  }, 33);

  return live;
}

// Called when the 3D View tab is left - the render loop otherwise keeps ticking at
// ~30fps forever in the background, burning CPU/GPU for a tab nobody's looking at.
// ensureLive() restarts it the next time the tab is reopened.
export function pauseLiveViewer() {
  if (liveTimer) { clearInterval(liveTimer); liveTimer = null; }
}
window.pauseLiveViewer = pauseLiveViewer;

// Called when the 3D View tab becomes visible - builds/refreshes the live scene from
// whatever was last passed to update3DViewer, so it always shows the current build.
export async function activateLiveViewer() {
  const container = document.getElementById('viewport3d_live');
  if (!container) return;
  const l = ensureLive(container);
  const empty = document.getElementById('v3d_live_empty');
  if (!livePkg) {
    if (empty) { empty.hidden = false; empty.textContent = 'No 3D preview for this weapon type'; }
    l.renderer.domElement.style.display = 'none';
    return;
  }
  if (empty) empty.hidden = true;
  l.renderer.domElement.style.display = '';
  const any = await assembleParts(livePkg, liveSel, liveManuTok, liveMaterialId, l.group);
  if (!any) return;
  frameCamera(l.camera, l.group, l.controls);
}

let genCounter = 0;

export async function update3DViewer(typeId, sel, manuTok, materialId, skipCardImage) {
  const pkg = TYPE_PKG[typeId] || null;
  livePkg = pkg; liveSel = sel; liveManuTok = manuTok; liveMaterialId = materialId;

  const gen = ++genCounter;
  await updateSnapshot(pkg, sel, manuTok, materialId, gen, skipCardImage);
  if (gen !== genCounter) return;

  // Keep the live tab in sync too, but only do the (heavier) work if it's already mounted -
  // no point loading a second copy of everything for a tab nobody has opened yet.
  if (live) await activateLiveViewer();
}

window.update3DViewer = update3DViewer;

// Shields have no 3D model at all yet, and their own 2D card picture (sprite2d.js's
// update2DViewerShield) already owns v3d_img/v3d_empty by the time this runs - calling
// update3DViewer(null,...) would either crash reaching into assembleParts() with a weapon-
// shaped sel (skipCardImage=true) or clobber the just-rendered 2D picture with "no 3D preview"
// text (skipCardImage=false, since that branch runs before the skip check). This just clears
// the live-viewer's own state so the separate "3D View" tab correctly shows its own empty
// state instead of a stale previous weapon's model, without touching the card's own image.
export function clearLiveFor3DOnly() {
  livePkg = null; liveSel = null; liveManuTok = null; liveMaterialId = null;
}
window.clearLiveFor3DOnly = clearLiveFor3DOnly;
window.activateLiveViewer = activateLiveViewer;

// Tab-switching already pauses the loop, but minimizing/backgrounding the whole window
// doesn't go through openTab() at all - without this it keeps rendering at ~30fps while
// the window isn't even on screen.
document.addEventListener('visibilitychange', () => {
  if (document.hidden) {
    pauseLiveViewer();
  } else if (document.querySelector('.tab[data-tab="view3d"]')?.classList.contains('active')) {
    activateLiveViewer();
  }
});

