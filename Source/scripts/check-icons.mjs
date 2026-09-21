// Bagimlilik yukseltmelerinden sonra kullanilan lucide-react ikon adlarinin hala gecerli oldugunu dogrular.
// Kullanim: Source dizininden `node scripts/check-icons.mjs`
import { readFileSync, readdirSync, statSync } from 'node:fs';
import { join } from 'node:path';
import * as lucide from 'lucide-react';

const files = [];
(function walk(dir) {
  for (const entry of readdirSync(dir)) {
    const full = join(dir, entry);
    if (statSync(full).isDirectory()) walk(full);
    else if (/\.jsx?$/.test(entry)) files.push(full);
  }
})('src');

let problems = 0;
for (const file of files) {
  const source = readFileSync(file, 'utf8');
  for (const match of source.matchAll(/import\s*\{([^}]*)\}\s*from\s*'lucide-react'/g)) {
    const names = match[1].split(',').map((name) => name.trim()).filter(Boolean);
    const missing = names.filter((name) => !(name in lucide));
    if (missing.length > 0) {
      problems += missing.length;
      console.log(`${file.replace(/\\/g, '/')} => ${missing.join(', ')}`);
    }
  }
}
console.log(problems === 0 ? 'lucide-react: eksik ikon yok' : `lucide-react: ${problems} eksik ikon`);
process.exit(problems === 0 ? 0 : 1);
