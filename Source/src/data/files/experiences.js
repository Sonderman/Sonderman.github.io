import { personalData } from '../personalData';

// VS Code penceresindeki "experiences.html" onizlemesinin icerigi.
// Stiller satir ici tutulur; uzak CDN (cdn.tailwindcss.com) kullanilmaz, boylece
// onizleme ucuncu parti bir kaynaga bagimli olmadan ve offline da ayni gorunur.
const generateExperiencesHTML = () => {
  const { resume } = personalData;

  return `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Experiences</title>
<style>
  :root {
    --bg: #1f2428;
    --panel: #24292e;
    --line: #444c56;
    --accent: #3b82f6;
    --accent-soft: rgba(59, 130, 246, .5);
    --text: #d1d5db;
    --strong: #f3f4f6;
    --muted: #9ca3af;
    --dim: #6b7280;
    --orange: #fb923c;
    --emerald: #10b981;
  }
  *, *::before, *::after { box-sizing: border-box; }
  body {
    margin: 0;
    padding: 24px;
    background: var(--bg);
    color: var(--text);
    font-family: ui-sans-serif, system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
    line-height: 1.5;
  }
  ::-webkit-scrollbar { width: 10px; height: 10px; }
  ::-webkit-scrollbar-track { background: var(--bg); }
  ::-webkit-scrollbar-thumb { background: #30363d; border-radius: 5px; border: 2px solid var(--bg); }
  ::-webkit-scrollbar-thumb:hover { background: #454d55; }

  .wrap { max-width: 1024px; margin: 0 auto; padding-bottom: 48px; }
  .columns { display: grid; grid-template-columns: 1fr; gap: 32px; }
  @media (min-width: 1024px) { .columns { grid-template-columns: 2fr 1fr; } }

  h2 { display: flex; align-items: center; gap: 12px; margin: 0 0 16px; font-size: 1.25rem; line-height: 1.75rem; font-weight: 700; color: var(--strong); }
  .section-title { font-size: 1.5rem; line-height: 2rem; margin-bottom: 0; border-bottom: 1px solid var(--line); padding-bottom: 8px; }

  .timeline { display: flex; flex-direction: column; gap: 32px; }
  .entry { position: relative; border-left: 2px solid var(--line); padding-left: 24px; transition: border-color .3s; }
  .entry:hover { border-color: var(--accent); }
  .entry::before {
    content: '';
    position: absolute;
    left: -9px;
    top: 0;
    width: 16px;
    height: 16px;
    border-radius: 9999px;
    background: var(--panel);
    border: 2px solid var(--accent);
  }
  .card { background: var(--panel); border: 1px solid var(--line); border-radius: 8px; padding: 24px; transition: border-color .3s, box-shadow .3s; }
  .card:hover { border-color: var(--accent-soft); box-shadow: 0 10px 15px -3px rgba(0, 0, 0, .3); }
  .card-head { display: flex; justify-content: space-between; align-items: flex-start; gap: 12px; margin-bottom: 8px; }
  .card-head h3 { margin: 0; font-size: 1.25rem; line-height: 1.75rem; font-weight: 700; color: var(--strong); transition: color .3s; }
  .card:hover .card-head h3 { color: #60a5fa; }
  .subtitle { margin: 0; font-size: .875rem; line-height: 1.25rem; color: var(--muted); }
  .date {
    flex-shrink: 0;
    font-family: ui-monospace, SFMono-Regular, Menlo, monospace;
    font-size: .75rem;
    line-height: 1rem;
    color: #60a5fa;
    background: rgba(59, 130, 246, .1);
    border: 1px solid rgba(59, 130, 246, .2);
    border-radius: 4px;
    padding: 4px 8px;
    white-space: nowrap;
  }
  .details { list-style: none; margin: 16px 0 0; padding: 0; font-size: .875rem; line-height: 1.625; display: flex; flex-direction: column; gap: 8px; }
  .details li { display: flex; align-items: flex-start; gap: 8px; }
  .details li::before { content: ''; flex-shrink: 0; margin-top: 6px; width: 6px; height: 6px; border-radius: 9999px; background: var(--accent); }

  .aside { display: flex; flex-direction: column; gap: 32px; }
  .panel { background: var(--panel); border: 1px solid var(--line); border-radius: 12px; padding: 24px; }
  .panel h2 { gap: 8px; }
  .eyebrow { margin: 0 0 8px; font-size: .75rem; line-height: 1rem; font-weight: 600; letter-spacing: .05em; text-transform: uppercase; color: var(--dim); }
  .badges { display: flex; flex-wrap: wrap; gap: 8px; }
  .badges img { height: 24px; }

  .edu { border-left: 2px solid var(--line); padding-left: 16px; margin-bottom: 16px; }
  .edu h3 { margin: 0; font-size: 1rem; line-height: 1.5rem; font-weight: 600; color: #ffffff; }
  .edu .school { margin: 0 0 4px; font-size: .875rem; line-height: 1.25rem; color: var(--orange); }
  .edu .years { margin: 0; font-size: .75rem; line-height: 1rem; color: var(--dim); }

  .icon-blue { color: var(--accent); }
  .icon-emerald { color: var(--emerald); }
  .icon-orange { color: var(--orange); }
</style>
</head>
<body>

<div class="wrap">
  <div class="columns">
    <!-- Left Column: Experience -->
    <div class="timeline">
      <h2 class="section-title"><span class="icon-blue">⚡</span> Experiences</h2>

      ${resume.experience.map((exp) => `
      <div class="entry">
        <div class="card">
          <div class="card-head">
            <div>
              <h3>${exp.title}</h3>
              <p class="subtitle">${exp.subtitle || ''}</p>
            </div>
            <span class="date">${exp.date}</span>
          </div>
          <ul class="details">
            ${(exp.details || []).map(detail => `
            <li><span>${detail}</span></li>`).join('')}
          </ul>
        </div>
      </div>`).join('')}
    </div>

    <!-- Right Column: Skills & Education -->
    <div class="aside">
      <!-- Skills -->
      <div class="panel">
        <h2><span class="icon-emerald">🛠</span> Tech Stack</h2>
        <p class="eyebrow">Core</p>
        <div class="badges">
          ${personalData.skills.map(skill => {
            // shields.io statik rozet: etiket encodeURIComponent ile kodlanir.
            // Ham '#' (or. "C#") URL'in geri kalanini fragment yapar ve rozet 404 doner.
            const label = encodeURIComponent(skill.name);
            const skillColor = skill.name === 'Flutter' ? '02569B' :
                            skill.name === 'Dart' ? '0175C2' :
                            skill.name === 'Unity Engine' ? '000000' :
                            skill.name === 'C#' ? '239120' : '555555';
            // simple-icons slug'lari; gecerli slug yoksa logo parametresi eklenmez.
            const logo = { 'Flutter': 'flutter', 'Dart': 'dart', 'Unity Engine': 'unity' }[skill.name];
            const logoParam = logo ? `&logo=${logo}&logoColor=white` : '';
            return `<img src="https://img.shields.io/badge/${label}-%23${skillColor}.svg?style=flat-square${logoParam}" alt="${skill.name}" class="badge">`;
          }).join('')}
        </div>
      </div>

      <!-- Education -->
      <div class="panel">
        <h2><span class="icon-orange">🎓</span> Education</h2>
        ${resume.education.map(edu => `
        <div class="edu">
          <h3>${edu.title}</h3>
          <p class="school">${edu.subtitle}</p>
          <p class="years">${edu.date}</p>
        </div>`).join('')}
      </div>
    </div>
  </div>
</div>
</body>
</html>
`;
};

export default generateExperiencesHTML();
;
