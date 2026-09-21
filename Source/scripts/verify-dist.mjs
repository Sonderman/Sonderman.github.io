// Build cikisini dogrular: index.html referanslari ve koddan cagrilan mutlak yollar mevcut mu?
// Kullanim: node scripts/verify-dist.mjs <dizin>   (Source/dist veya depo koku)
import { readFileSync, existsSync, readdirSync, statSync } from 'node:fs';
import { join, resolve } from 'node:path';

const target = resolve(process.argv[2] ?? 'dist');
const errors = [];
const warnings = [];

function fail(message) {
  errors.push(message);
}

if (!existsSync(target) || !statSync(target).isDirectory()) {
  console.error(`[HATA] Dizin bulunamadi: ${target}`);
  process.exit(1);
}

const indexPath = join(target, 'index.html');
if (!existsSync(indexPath)) {
  console.error(`[HATA] index.html yok: ${indexPath}`);
  process.exit(1);
}

const html = readFileSync(indexPath, 'utf8');

for (const match of html.matchAll(/(?:src|href)="([^"]+)"/g)) {
  const ref = match[1];
  if (/^(https?:|mailto:|#|\/\/)/.test(ref)) continue;
  const file = join(target, ref.replace(/^\.\//, ''));
  if (!existsSync(file)) fail(`index.html referansi eksik: ${ref}`);
}

const assetDir = join(target, 'assets');
if (!existsSync(assetDir) || readdirSync(assetDir).length === 0) {
  fail('assets/ dizini bos veya yok.');
}

// Koddan cagrilan mutlak yollar (gorseller, oyun build'leri, CV) kopyalanmis mi?
const bundles = existsSync(assetDir)
  ? readdirSync(assetDir).filter((name) => /\.(js|css)$/.test(name))
  : [];

const runtimeRefs = new Set();
for (const bundle of bundles) {
  const code = readFileSync(join(assetDir, bundle), 'utf8');
  for (const match of code.matchAll(/["'`](\/(?:images|games|cv[^"'`]*)\.[a-z0-9]+)["'`]/gi)) {
    runtimeRefs.add(match[1]);
  }
  for (const match of code.matchAll(/["'`](\/(?:images|games)\/[^"'`]+)["'`]/gi)) {
    runtimeRefs.add(match[1]);
  }
}

if (runtimeRefs.size === 0) {
  warnings.push('Kod icinde /images veya /games referansi bulunamadi (beklenmiyorsa sorun degil).');
}

for (const ref of runtimeRefs) {
  // Tarayicida birlestirilen yollar (or. `/games/${id}/Build`) burada cozulemez; ayrica kontrol edilir.
  if (ref.includes('${')) continue;
  const file = join(target, ref.slice(1));
  if (!existsSync(file)) fail(`Kod referansi eksik: ${ref}`);
}

// Unity build'leri: her oyun klasorunde Web.loader.js bulunmali.
const gamesDir = join(target, 'games');
if (!existsSync(gamesDir)) {
  fail('games/ dizini eksik.');
} else {
  const games = readdirSync(gamesDir).filter((name) => statSync(join(gamesDir, name)).isDirectory());
  if (games.length === 0) fail('games/ dizini bos.');
  for (const game of games) {
    const loader = join(gamesDir, game, 'Build', 'Web.loader.js');
    if (!existsSync(loader)) fail(`Unity loader eksik: games/${game}/Build/Web.loader.js`);
  }
  console.log(`  Unity build'leri: ${games.length} oyun kontrol edildi`);
}

// Yayinda kalmasi zorunlu dosyalar
for (const required of [
  'app-ads.txt',
  'favicon.ico',
  'robots.txt',
  'sitemap.xml',
  'cv.pdf',
  'og-image.png',
]) {
  if (!existsSync(join(target, required))) fail(`Zorunlu dosya eksik: ${required}`);
}

const googleFile = readdirSync(target).find((name) => /^google[0-9a-f]+\.html$/i.test(name));
if (!googleFile) fail('Google site dogrulama dosyasi eksik.');

console.log(`Dogrulanan dizin: ${target}`);
console.log(`  index.html referanslari: tamam`);
console.log(`  kod referanslari: ${runtimeRefs.size} adet kontrol edildi`);
for (const warning of warnings) console.log(`  UYARI: ${warning}`);

if (errors.length > 0) {
  console.error('\nHATALAR:');
  for (const error of errors) console.error(`  - ${error}`);
  process.exit(1);
}

console.log('Sonuc: tum referanslar mevcut.');
