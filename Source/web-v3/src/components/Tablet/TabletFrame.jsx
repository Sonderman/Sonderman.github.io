import React from 'react';
import UnityContainer from './UnityContainer';

const TabletFrame = () => {
    return (
        <div className="relative w-full max-w-[1300px] h-[750px] mx-auto my-10 group mt-20">
            {/* Top Triggers */}
            <div className="absolute -top-2 left-12 w-32 h-4 bg-gradient-to-b from-[#333] to-[#1a1a1a] rounded-t-lg border-x border-t border-white/10 shadow-inner"></div>
            <div className="absolute -top-2 right-12 w-32 h-4 bg-gradient-to-b from-[#333] to-[#1a1a1a] rounded-t-lg border-x border-t border-white/10 shadow-inner"></div>

            {/* Main Console Body */}
            <div className="relative w-full h-full bg-[#1a1a1a] rounded-[40px] shadow-[0_0_50px_rgba(0,0,0,0.5)] border-4 border-[#222] flex items-center p-2">
                
                {/* Left Handle (Controls) */}
                <div className="w-[120px] h-full flex flex-col items-center justify-center gap-8 px-4">
                    {/* Joystick L */}
                    <div className="w-16 h-16 rounded-full bg-gradient-to-br from-[#333] via-[#222] to-[#111] shadow-[inset_0_2px_10px_rgba(0,0,0,0.8),0_5px_15px_rgba(0,0,0,0.4)] border border-white/5 relative flex items-center justify-center">
                        <div className="w-14 h-14 rounded-full bg-[#1a1a1a] border border-[#333] shadow-inner flex items-center justify-center">
                            <div className="w-10 h-10 rounded-full bg-gradient-to-t from-[#222] to-[#333] shadow-lg"></div>
                        </div>
                    </div>

                    {/* D-Pad */}
                    <div className="relative w-20 h-20">
                        <div className="absolute top-1/2 left-0 w-full h-7 -translate-y-1/2 bg-[#111] rounded-sm border border-white/5 shadow-lg"></div>
                        <div className="absolute top-0 left-1/2 w-7 h-full -translate-x-1/2 bg-[#111] rounded-sm border border-white/5 shadow-lg"></div>
                        {/* Center cover */}
                        <div className="absolute top-1/2 left-1/2 w-8 h-8 -translate-x-1/2 -translate-y-1/2 bg-[#111]"></div>
                    </div>
                </div>

                {/* Screen Area */}
                <div 
                    id="console-screen"
                    className="flex-1 h-full bg-black rounded-[25px] overflow-hidden relative border-8 border-[#0a0a0a] shadow-[inset_0_0_20px_rgba(0,0,0,0.9)]"
                    style={{ containerType: 'size' }}
                >
                    <UnityContainer />
                </div>

                {/* Right Handle (Controls) */}
                <div className="w-[120px] h-full flex flex-col items-center justify-center gap-8 px-4">
                    {/* ABXY Buttons */}
                    <div className="grid grid-cols-2 gap-2 transform rotate-45">
                        {['Y', 'X', 'B', 'A'].map((btn) => (
                            <div key={btn} className="w-8 h-8 rounded-full bg-[#111] border border-white/10 shadow-lg flex items-center justify-center -rotate-45">
                                <span className="text-[10px] font-bold text-gray-400">{btn}</span>
                            </div>
                        ))}
                    </div>

                    {/* Joystick R */}
                    <div className="w-16 h-16 rounded-full bg-gradient-to-br from-[#333] via-[#222] to-[#111] shadow-[inset_0_2px_10px_rgba(0,0,0,0.8),0_5px_15px_rgba(0,0,0,0.4)] border border-white/5 relative flex items-center justify-center">
                        <div className="w-14 h-14 rounded-full bg-[#1a1a1a] border border-[#333] shadow-inner flex items-center justify-center">
                            <div className="w-10 h-10 rounded-full bg-gradient-to-t from-[#222] to-[#333] shadow-lg"></div>
                        </div>
                    </div>
                </div>
            </div>

            {/* Bottom Glow Effect */}
            <div className="absolute -bottom-4 left-1/2 -translate-x-1/2 w-2/3 h-1 bg-blue-500/20 blur-xl"></div>
        </div>
    );
};

export default TabletFrame;

