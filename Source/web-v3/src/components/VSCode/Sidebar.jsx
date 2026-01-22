import React from 'react';
import { Files, FileText, Settings, Search, GitBranch } from 'lucide-react';

const Sidebar = ({ files, activeFile, onFileClick }) => {
    return (
        <div className="w-64 bg-[#252526] border-r border-[#333] flex flex-row h-full">
            {/* Activity Bar */}
            <div className="w-12 bg-[#333333] flex flex-col items-center py-4 space-y-6 text-[#858585]">
                <Files className="w-6 h-6 text-white cursor-pointer hover:text-white" />
                <Search className="w-6 h-6 cursor-pointer hover:text-white" />
                <GitBranch className="w-6 h-6 cursor-pointer hover:text-white" />
                <div className="flex-grow" />
                <Settings className="w-6 h-6 cursor-pointer hover:text-white" />
            </div>

            {/* Side Bar Content */}
            <div className="flex-1 flex flex-col">
                <div className="h-8 flex items-center px-4 text-xs font-bold text-[#bbbbbb] uppercase tracking-wider">
                    Explorer
                </div>
                <div className="flex-1 overflow-y-auto">
                    <div className="px-2 py-1 text-xs font-bold text-blue-400 uppercase">
                        Portfolio
                    </div>
                    <div className="flex flex-col">
                        {files.map((file) => (
                            <div
                                key={file.name}
                                onClick={() => onFileClick(file)}
                                className={`flex items-center px-4 py-1 cursor-pointer text-sm ${activeFile?.name === file.name
                                        ? 'bg-[#37373d] text-white'
                                        : 'text-[#cccccc] hover:bg-[#2a2d2e]'
                                    }`}
                            >
                                <FileText className="w-4 h-4 mr-2 text-blue-400" />
                                {file.name}
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default Sidebar;
