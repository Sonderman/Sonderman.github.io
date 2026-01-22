import React from 'react';
import { motion } from 'framer-motion';

const SkillBar = ({ name, percentage, delay }) => {
  return (
    <motion.div 
      initial={{ opacity: 0, x: -20 }}
      animate={{ opacity: 1, x: 0 }}
      transition={{ duration: 0.5, delay: delay }}
      className="flex flex-col gap-3 w-full"
    >
      <div className="flex justify-between items-center">
        <span className="text-white text-lg font-semibold">{name}</span>
        <span className="text-[#fbce41] text-lg font-bold">{percentage}%</span>
      </div>
      <div className="h-3 w-full bg-[#0f172a] rounded-full overflow-hidden relative">
        {/* Background track */}
        <div className="absolute inset-0 bg-slate-900/50" />
        <motion.div 
          initial={{ width: 0 }}
          animate={{ width: `${percentage}%` }}
          transition={{ duration: 1.2, delay: delay + 0.2, ease: [0.34, 1.56, 0.64, 1] }}
          className="h-full rounded-full bg-gradient-to-r from-[#06b6d4] via-[#2dd4bf] to-[#fbce41] relative z-10"
        >
          {/* Subtle shine effect */}
          <div className="absolute inset-0 bg-gradient-to-b from-white/20 to-transparent" />
        </motion.div>
      </div>
    </motion.div>
  );
};

const SkillsPreview = ({ skills }) => {
  return (
    <div className="w-full h-full p-4 md:p-8 flex flex-col items-center justify-center bg-[#1e1e1e] overflow-hidden">
      <div className="w-full max-w-4xl flex flex-col h-full justify-center">
        <motion.div 
          initial={{ opacity: 0, y: -10 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex items-center gap-3 mb-6 shrink-0"
        >
          <span className="text-[#fbce41] text-2xl font-bold font-mono">{"</>"}</span>
          <h1 className="text-2xl font-bold text-white tracking-tight">
            Skills
          </h1>
        </motion.div>

        <motion.div 
          initial={{ opacity: 0, scale: 0.98 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.4 }}
          className="w-full bg-[#1e293b]/40 backdrop-blur-md border border-white/5 rounded-2xl p-6 md:p-10 shadow-2xl overflow-y-auto custom-scrollbar"
        >
          <div className="flex flex-col gap-6">
            {skills.map((skill, index) => (
              <SkillBar 
                key={skill.name} 
                name={skill.name} 
                percentage={skill.percentage} 
                delay={index * 0.1}
              />
            ))}
          </div>
        </motion.div>
      </div>
    </div>
  );
};


export default SkillsPreview;

