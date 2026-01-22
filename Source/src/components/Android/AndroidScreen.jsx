import React, { useState } from 'react';
import { projects } from '../../data/projects';
import AppIcon from './AppIcon';
import ProjectCarousel from './ProjectCarousel';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Wifi, Battery, Signal, Search, Mic, Phone, MessageSquare, Globe, Camera } from 'lucide-react';
import chromeIcon from '../../assets/icons/chrome.png';
import stockBg from '../../assets/stock_bg.jpg';

const AndroidScreen = () => {
    const [openApp, setOpenApp] = useState(null);
    const [currentTime, setCurrentTime] = useState('');

    React.useEffect(() => {
        const updateTime = () => {
            const now = new Date();
            const hours = now.getHours();
            const minutes = now.getMinutes();
            const ampm = hours >= 12 ? 'PM' : 'AM';
            const formattedHours = hours % 12 || 12;
            const formattedMinutes = minutes < 10 ? `0${minutes}` : minutes;
            setCurrentTime(`${formattedHours}:${formattedMinutes} ${ampm}`);
        };

        updateTime(); // Initial call
        const interval = setInterval(updateTime, 1000);

        return () => clearInterval(interval);
    }, []);

    const systemApps = [
        { id: 'sys-1', name: 'Phone', icon: Phone, color: 'bg-green-600' },
        { id: 'sys-2', name: 'Messages', icon: MessageSquare, color: 'bg-blue-600' },
        { id: 'sys-3', name: 'Chrome', icon: chromeIcon, color: '', url: 'https://www.google.com' },
        { id: 'sys-4', name: 'Camera', icon: Camera, color: 'bg-gray-700' },
    ];

    const mobileApps = projects.filter(p => p.type === 'app' && p.images?.length > 1).map((app, index) => ({
        ...app,
        id: `project-${index}`,
        name: app.title, // AppIcon expects "name"
        icon: `/images/projects/${app.images[0]}` // Use first image as icon
    }));

    return (
        <div 
            className="w-full h-full bg-cover bg-bottom relative overflow-hidden flex flex-col items-center pb-4"
            style={{ backgroundImage: `url(${stockBg})` }}
        >
            <div className="absolute inset-0 bg-black/10"></div>
            {/* Status Bar - Compact but clear of notch */}
            <div className="h-9 flex items-end justify-between px-5 pb-1 text-white text-[10px] bg-black/20 z-20 w-full mb-1">
                <span>{currentTime}</span>
                <div className="flex space-x-2">
                    <Signal size={12} />
                    <Wifi size={12} />
                    <Battery size={12} />
                </div>
            </div>

            {/* Date Widget - Compact */}
            <div className="w-full px-6 pt-1 pb-0 z-20 text-center">
                <div className="text-3xl font-thin text-white tracking-tighter drop-shadow-md">
                    {currentTime.split(' ')[0]}
                </div>
                <div className="text-white/90 text-sm font-medium tracking-wide mt-1 uppercase opacity-80">
                   {new Date().toLocaleDateString('en-US', { weekday: 'long', month: 'short', day: 'numeric' })}
                </div>
            </div>

            {/* Home Screen Icons - Tightened gap */}
            <div className="flex-1 px-4 grid grid-cols-4 grid-rows-4 gap-x-1 gap-y-3 content-start z-10 pt-2">
                {mobileApps.map((app) => (
                    <AppIcon key={app.id} app={app} onClick={setOpenApp} />
                ))}
            </div>

            {/* Google Search Widget - Compact margin */}
            <div className="w-[85%] bg-white/90 backdrop-blur-md rounded-full h-9 flex items-center px-4 justify-between mb-3 shadow-lg z-20 mx-auto">
                <div className="flex items-center space-x-3">
                    <span className="text-xl font-bold bg-clip-text text-transparent bg-gradient-to-r from-blue-500 via-red-500 to-yellow-500">G</span>
                    <Search className="text-gray-400" size={16} />
                </div>
                <Mic className="text-blue-500" size={16} />
            </div>

            {/* Dock - Standard System Apps (Non-interactive) */}
            <div className="h-16 bg-white/20 backdrop-blur-xl mb-4 mx-2 rounded-[20px] flex items-center justify-around px-4 gap-2 z-20 border border-white/10 shadow-2xl">
                {systemApps.map((app) => (
                    <AppIcon 
                        key={app.id} 
                        app={app} 
                        interactive={true} 
                        onClick={(clickedApp) => {
                            if (clickedApp.url) {
                                window.open(clickedApp.url, '_blank', 'noopener,noreferrer');
                            }
                        }}
                    />
                ))}
            </div>

            {/* Gesture Navigation Bar */}
            <div className="h-1 w-full flex justify-center pb-2 mb-1 z-20">
                <div className="w-1/3 h-1 bg-white/50 rounded-full"></div>
            </div>

            {/* App Modal */}
            <AnimatePresence>
                {openApp && (
                    <motion.div
                        initial={{ opacity: 0, scale: 0.9, y: 100 }}
                        animate={{ opacity: 1, scale: 1, y: 0 }}
                        exit={{ opacity: 0, scale: 0.95, y: 20 }}
                        transition={{ type: "spring", damping: 25, stiffness: 300 }}
                        className="absolute inset-0 bg-white z-40 flex flex-col font-sans"
                    >
                        {/* App Header */}
                        <div className={`${openApp.color} h-12 flex items-center justify-between px-4 text-white shadow-sm`}>
                            <span className="font-bold">{openApp.name}</span>
                            <button onClick={() => setOpenApp(null)} className="p-1 hover:bg-white/20 rounded-full">
                                <X size={20} />
                            </button>
                        </div>

                        {/* App Content */}
                        <div className="flex-1 flex flex-col items-center justify-center p-4 bg-gray-900 border-t border-white/10">
                            <ProjectCarousel images={openApp.images} title={openApp.name} />
                            
                            <div className="mt-2 text-white text-center max-w-md">
                                <h2 className="text-xl font-bold mb-2">{openApp.name}</h2>
                                <p className="text-gray-400 text-sm">{openApp.description}</p>
                            </div>
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>
        </div>
    );
};

export default AndroidScreen;
