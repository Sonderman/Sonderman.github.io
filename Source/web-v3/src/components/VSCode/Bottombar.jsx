import React from 'react';
import {
  VscBell,
  VscCheck,
  VscError,
  VscWarning,
  VscSourceControl,
} from 'react-icons/vsc';

const Bottombar = () => {
  return (
    <footer className="h-[25px] bg-vscode-bottom-bg border-t border-[#191d20] flex items-center justify-between px-2 text-[11px] text-gray-300 select-none font-sans">
       <div className="flex items-center h-full space-x-4">
          <div className="flex items-center hover:bg-white/10 px-2 h-full cursor-pointer">
             <VscSourceControl className="mr-1" />
             <p>main</p>
          </div>
          <div className="flex items-center hover:bg-white/10 px-2 h-full cursor-pointer">
             <VscError className="mr-1" />
             <p>0</p>
             <VscWarning className="mr-1 ml-2" />
             <p>0</p>
          </div>
       </div>

       <div className="flex items-center h-full space-x-4">
          <div className="flex items-center hover:bg-white/10 px-2 h-full cursor-pointer">
             <VscCheck className="mr-1" />
             <p>Prettier</p>
          </div>
          <div className="flex items-center hover:bg-white/10 px-2 h-full cursor-pointer">
             <VscBell />
          </div>
       </div>
    </footer>
  );
};

export default Bottombar;
