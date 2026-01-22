import React from 'react';

const Titlebar = () => {
  return (
    <section className="bg-vscode-titlebar-bg h-[30px] flex items-center justify-center text-vscode-text text-[13px] border-b border-[#191d20] select-none font-sans relative">
      <div className="flex items-center absolute left-0 px-2">
         {/* VS Code Icon */}
         <img src="/vscode_icon.svg" alt="VSCode" className="w-[15px] h-[15px] mr-2" />
         
         {/* Menu Items (Hidden on small screens in original, but we keep simple) */}
         <div className="hidden md:flex space-x-3 ml-2 text-[13px]">
            <p className="cursor-pointer hover:bg-white/10 px-1 rounded">File</p>
            <p className="cursor-pointer hover:bg-white/10 px-1 rounded">Edit</p>
            <p className="cursor-pointer hover:bg-white/10 px-1 rounded">View</p>
            <p className="cursor-pointer hover:bg-white/10 px-1 rounded">Go</p>
            <p className="cursor-pointer hover:bg-white/10 px-1 rounded">Run</p>
            <p className="cursor-pointer hover:bg-white/10 px-1 rounded">Terminal</p>
            <p className="cursor-pointer hover:bg-white/10 px-1 rounded">Help</p>
         </div>
      </div>

      {/* Title */}
      <p className="font-medium text-[13px] opacity-80">Ali Haydar AYAR - Visual Studio Code</p>

      {/* Window Controls */}
      <div className="flex items-center absolute right-0 px-2 space-x-2">
         <span className="w-[13px] h-[13px] bg-[#f1fa8c] rounded-full cursor-pointer hover:opacity-80"></span>
         <span className="w-[13px] h-[13px] bg-[#50fa7b] rounded-full cursor-pointer hover:opacity-80"></span>
         <span className="w-[13px] h-[13px] bg-[#ff5555] rounded-full cursor-pointer hover:opacity-80"></span>
      </div>
    </section>
  );
};

export default Titlebar;
