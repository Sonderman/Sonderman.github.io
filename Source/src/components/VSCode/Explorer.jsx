import React, { useState } from 'react';
import { VscChevronRight } from 'react-icons/vsc';

const Explorer = ({ files, activeFile, onFileClick }) => {
  const [open, setOpen] = useState(true);

  return (
    <div className="w-[200px] md:w-[240px] bg-vscode-explorer-bg flex flex-col h-full border-r border-[#191d20] text-vscode-text font-sans">
       <div className="px-4 py-3 text-[11px] font-bold uppercase tracking-wider text-gray-400">Explorer</div>
       
       <div>
          <div 
            className="flex items-center px-1 py-1 cursor-pointer hover:bg-vscode-explorer-hover font-bold text-[11px] tracking-wide text-gray-300 uppercase"
            onClick={() => setOpen(!open)}
          >
             <VscChevronRight 
                className={`mr-1 transition-transform duration-200 ${open ? 'rotate-90' : ''}`} 
                size={16}
             />
             Portfolio
          </div>

          {open && (
             <div className="flex flex-col mt-1">
                {files.map(file => (
                   <div 
                      key={file.name}
                      onClick={() => onFileClick(file)}
                      className={`flex items-center pl-6 py-1 cursor-pointer text-[13px] hover:bg-vscode-explorer-hover ${
                          activeFile?.name === file.name ? 'bg-vscode-explorer-hover text-white' : 'text-gray-400'
                      }`}
                   >
                     {/* Simplified icons mapping based on extension */}
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
                      {file.name}
                   </div>
                ))}
             </div>
          )}
       </div>
    </div>
  );
};

export default Explorer;
