import React, { useRef } from 'react';
import { X } from 'lucide-react'; // Using Lucide X for close button for now or VSCode icons if available

const Tabsbar = ({ openFiles, activeFile, onCloseFile, onSetActiveFile }) => {
  const scrollRef = useRef(null);

  const handleWheel = (e) => {
    if (scrollRef.current) {
      // If deltaY is present (standard mouse wheel), use it for horizontal scrolling.
      // If deltaX is present (trackpad horizontal), use it as is.
      const scrollAmount = e.deltaY !== 0 ? e.deltaY : e.deltaX;
      scrollRef.current.scrollLeft += scrollAmount;
    }
  };

  return (
    <div 
      ref={scrollRef}
      onWheel={handleWheel}
      className="flex flex-nowrap bg-vscode-tabs-bg overflow-x-auto h-[35px] no-scrollbar select-none sticky top-0 z-20"
    >
       {openFiles.map(file => (
          <div
            key={file.name}
            onClick={() => onSetActiveFile(file)}
            className={`flex items-center px-4 min-w-[120px] max-w-[200px] flex-shrink-0 cursor-pointer border-r border-[#191d20] border-t-2 text-[13px] group transition-colors ${
               activeFile?.name === file.name 
                ? 'bg-vscode-tab-active text-white border-t-[#f9826c]' 
                : 'text-gray-500 hover:bg-[#2d2d2d] bg-[#1f2428] border-t-transparent'
            }`}
          >
             <img 
               src={
                   file.name.endsWith('.md') ? '/markdown_icon.svg' : 
                   file.name.endsWith('.js') ? '/js_icon.svg' : 
                   file.name.endsWith('.html') ? '/html_icon.svg' : 
                   file.name.endsWith('.css') ? '/css_icon.svg' : 
                   file.name.endsWith('.pdf') ? '/pdf_icon.png' : '/code_icon.svg'
               } 
               alt="icon" 
               className="w-[14px] h-[14px] mr-2" 
             />
             <span className="truncate mr-2">{file.name}</span>
             <button 
                onClick={(e) => {
                    e.stopPropagation();
                    onCloseFile(file);
                }}
                className={`ml-auto rounded-md hover:bg-white/20 p-0.5 ${
                    activeFile?.name === file.name ? 'opacity-100' : 'opacity-0 group-hover:opacity-100'
                }`}
             >
                <X size={12} />
             </button>
          </div>
       ))}
    </div>
  );
};

export default Tabsbar;
