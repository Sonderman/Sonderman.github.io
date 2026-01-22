export default `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Experiences</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #1f2428; }
        /* CustomScrollbar */
        ::-webkit-scrollbar { width: 10px; height: 10px; }
        ::-webkit-scrollbar-track { background: #1f2428; }
        ::-webkit-scrollbar-thumb { background: #30363d; border-radius: 5px; border: 2px solid #1f2428; }
        ::-webkit-scrollbar-thumb:hover { background: #454d55; }
    </style>
</head>
<body class="p-6">

<div class="not-prose font-sans text-gray-300 max-w-5xl mx-auto pb-12">
  <div class="grid lg:grid-cols-3 gap-8">
     <!-- Left Column: Experience -->
     <div class="lg:col-span-2 space-y-8">
        <h2 class="text-2xl font-bold text-gray-100 flex items-center gap-3 pb-2 border-b border-[#444c56]"> 
           <span class="text-blue-500">⚡</span> Experiences
        </h2>

        <!-- Job 1 -->
        <div class="relative pl-6 border-l-2 border-[#444c56] hover:border-blue-500 transition-colors duration-300">
           <div class="absolute -left-[9px] top-0 w-4 h-4 rounded-full bg-[#24292e] border-2 border-blue-500"></div>
           <div class="bg-[#24292e] p-6 rounded-lg border border-[#444c56] hover:border-blue-500/50 hover:shadow-lg transition-all group">
              <div class="flex justify-between items-start mb-2">
                 <div>
                    <h3 class="text-xl font-bold text-gray-100 group-hover:text-blue-400 transition-colors">Flutter & Unity Developer</h3>
                    <p class="text-gray-400 text-sm">Freelancer</p>
                 </div>
                 <span class="text-xs font-mono bg-blue-500/10 text-blue-400 px-2 py-1 rounded border border-blue-500/20">Apr 2024 - Present</span>
              </div>
              <ul class="space-y-2 text-gray-300 mt-4 text-sm leading-relaxed list-none p-0">
                 <li class="flex items-start gap-2">
                    <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-blue-500 shrink-0"></span>
                    <span>Published <b>80+ apps</b> on mobile platforms.</span>
                 </li>
                 <li class="flex items-start gap-2">
                    <span class="mt-1.5 w-1.5 h-1.5 rounded-full bg-blue-500 shrink-0"></span>
                    <span>Managed full lifecycle of mobile application development.</span>
                 </li>
              </ul>
           </div>
        </div>

        <!-- Job 2 -->
        <div class="relative pl-6 border-l-2 border-[#444c56] hover:border-purple-500 transition-colors duration-300">
           <div class="absolute -left-[9px] top-0 w-4 h-4 rounded-full bg-[#24292e] border-2 border-purple-500"></div>
           <div class="bg-[#24292e] p-6 rounded-lg border border-[#444c56] hover:border-purple-500/50 hover:shadow-lg transition-all group">
              <div class="flex justify-between items-start mb-2">
                 <div>
                    <h3 class="text-xl font-bold text-gray-100 group-hover:text-purple-400 transition-colors">Game Developer</h3>
                    <p class="text-gray-400 text-sm">Game Studio</p>
                 </div>
                 <span class="text-xs font-mono bg-purple-500/10 text-purple-400 px-2 py-1 rounded border border-purple-500/20">Mar 2023 - Mar 2024</span>
              </div>
              <p class="text-gray-300 text-sm mt-3 mb-3">Contributed to the development of 2 published mobile games.</p>
              <div class="flex flex-wrap gap-2">
                <span class="text-xs bg-[#2f363d] px-2 py-1 rounded text-gray-400 border border-[#444c56] hover:text-white transition-colors">Sky Wars Online: Istanbul</span>
                <span class="text-xs bg-[#2f363d] px-2 py-1 rounded text-gray-400 border border-[#444c56] hover:text-white transition-colors">Zombie Rush Drive</span>
              </div>
           </div>
        </div>
     </div>

     <!-- Right Column: Skills & Education -->
     <div class="space-y-8">
        
        <!-- Skills -->
        <div class="bg-[#24292e] p-6 rounded-xl border border-[#444c56]">
           <h2 class="text-xl font-bold text-gray-100 mb-4 flex items-center gap-2">
              <span class="text-emerald-500">🛠</span> Tech Stack
           </h2>
           <div class="space-y-4">
              <div>
                 <p class="text-xs text-gray-500 mb-2 uppercase tracking-wider font-semibold">Core</p>
                 <div class="flex flex-wrap gap-2">
                    <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat-square&logo=Flutter&logoColor=white" alt="Flutter" class="h-6">
                    <img src="https://img.shields.io/badge/dart-%230175C2.svg?style=flat-square&logo=dart&logoColor=white" alt="Dart" class="h-6">
                    <img src="https://img.shields.io/badge/unity-%23000000.svg?style=flat-square&logo=unity&logoColor=white" alt="Unity" class="h-6">
                    <img src="https://img.shields.io/badge/c%23-%23239120.svg?style=flat-square&logo=c-sharp&logoColor=white" alt="C#" class="h-6">
                 </div>
              </div>
           </div>
        </div>

        <!-- Education -->
        <div class="bg-[#24292e] p-6 rounded-xl border border-[#444c56]">
           <h2 class="text-xl font-bold text-gray-100 mb-4 flex items-center gap-2">
              <span class="text-orange-500">🎓</span> Education
           </h2>
           <div class="border-l-2 border-[#444c56] pl-4">
              <h3 class="text-white font-semibold">Computer Engineering</h3>
              <p class="text-sm text-orange-400 mb-1">Karabuk University</p>
              <p class="text-xs text-gray-500">2015 - 2020</p>
           </div>
        </div>

     </div>
  </div>
</div>
</body>
</html>
`;
