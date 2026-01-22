import React from 'react';
import { motion } from 'framer-motion';

const SkillBar = ({ name, percentage, delay }) => {
  return (
    <motion.div 
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5, delay: delay }}
      className="flex flex-col gap-2 w-full"
    >
      <div className="flex justify-between items-center text-sm">
        <span className="text-gray-300 font-medium">{name}</span>
        <span className="text-[#fbce41] font-bold">{percentage}%</span>
      </div>
      <div className="h-2 w-full bg-white/10 border border-white/5 rounded-full overflow-hidden">
        <motion.div 
          initial={{ width: 0 }}
          animate={{ width: `${percentage}%` }}
          transition={{ duration: 1, delay: delay + 0.2, ease: "easeOut" }}
          className="h-full rounded-full bg-gradient-to-r from-[#fbce41] to-[#2dd4bf]"
        />
      </div>
    </motion.div>
  );
};

const SkillsPreview = ({ skills }) => {
  return (
    <div className="w-full h-full p-8 overflow-y-auto custom-scrollbar flex flex-col items-center">
      <motion.h1 
        initial={{ opacity: 0, y: -20 }}
        animate={{ opacity: 1, y: 0 }}
        className="text-3xl font-bold text-white mb-12"
      >
        My Skills
      </motion.h1>

      <div className="w-full max-w-6xl grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
        {skills.map((skill, index) => (
          <SkillBar 
            key={skill.name} 
            name={skill.name} 
            percentage={skill.percentage} 
            delay={index * 0.1}
          />
        ))}
      </div>
    </div>
  );
};

export default SkillsPreview;
