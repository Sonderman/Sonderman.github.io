import React from 'react';
import AndroidScreen from './AndroidScreen';

const PhoneFrame = () => {
    return (
        <div className="relative w-[320px] h-[693px] bg-black rounded-[45px] shadow-2xl border-4 border-[#333] p-4 mx-auto transform hover:scale-105 transition-transform duration-300">
            {/* Screen Area */}
            <div className="w-full h-full bg-black rounded-[30px] overflow-hidden relative">
                <AndroidScreen />
            </div>

            {/* Notch / Camera */}
            <div className="absolute top-0 left-1/2 transform -translate-x-1/2 w-40 h-6 bg-black rounded-b-xl z-10 flex justify-center items-center">
                <div className="w-20 h-3 bg-[#222] rounded-full top-1 absolute"></div>
                <div className="w-2 h-2 bg-[#111] rounded-full absolute right-8 top-2"></div>
            </div>

            {/* Side Buttons (Visual) */}
            <div className="absolute top-24 -right-[6px] w-[6px] h-10 bg-[#333] rounded-r-md"></div>
            <div className="absolute top-40 -right-[6px] w-[6px] h-20 bg-[#333] rounded-r-md"></div>
        </div>
    );
};

export default PhoneFrame;
