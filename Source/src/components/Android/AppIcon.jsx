import React from 'react';
import { motion } from 'framer-motion';

const AppIcon = ({ app, onClick, interactive = true }) => {
    const Icon = app.icon;
    
    // Resolve icon source
    const getIconInfo = () => {
        if (!Icon) return { type: 'default' };
        
        if (typeof Icon === 'string') {
            // If it's a full URL or absolute path, use it directly
            if (Icon.startsWith('http') || Icon.startsWith('/') || Icon.startsWith('data:')) {
                return { type: 'image', src: Icon };
            }
            // If it's a simple filename, assume it's in the assets/icons folder (via public)
            // or if it was imported (Vite resolves it to a string/path)
            return { type: 'image', src: Icon };
        }
        
        // Assume it's a Component (Lucide)
        return { type: 'component', component: Icon };
    };

    const iconInfo = getIconInfo();

    return (
        <motion.div
            whileHover={{ scale: 1.1 }}
            whileTap={{ scale: 0.95 }}
            className={`flex flex-col items-center justify-center space-y-1 ${interactive ? 'cursor-pointer' : 'cursor-default'}`}
            onClick={() => interactive && onClick && onClick(app)}
        >
            <div className={`w-10 h-10 ${iconInfo.type === 'component' ? 'text-white ' + app.color : ''} rounded-lg flex items-center justify-center shadow-md overflow-hidden`}>
                {iconInfo.type === 'image' ? (
                    <img src={iconInfo.src} alt={app.name} className="w-full h-full object-cover" />
                ) : iconInfo.type === 'component' ? (
                    <iconInfo.component size={24} />
                ) : (
                    <div className="w-6 h-6 bg-white/20" />
                )}
            </div>
            <span className="text-[10px] text-white font-medium drop-shadow-md text-center leading-tight">{app.name}</span>
        </motion.div>
    );
};

export default AppIcon;
