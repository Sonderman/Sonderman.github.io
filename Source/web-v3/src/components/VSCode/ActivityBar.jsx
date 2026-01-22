import React from 'react';
import {
  VscAccount,
  VscSettings,
  VscMail,
  VscGithubAlt,
  VscCode,
  VscFiles,
  VscEdit,
} from 'react-icons/vsc';

const ActivityBar = ({ activeTab, onTabClick }) => {
  return (
    <aside className="w-[50px] bg-vscode-sidebar-bg flex flex-col justify-between items-center py-2 h-full border-r border-[#191d20]">
      <div className="flex flex-col w-full">
         <div 
            onClick={() => onTabClick('files')}
            className={`w-full h-[50px] flex items-center justify-center cursor-pointer border-l-2 transition-colors ${
               activeTab === 'files' ? 'border-vscode-accent text-gray-200' : 'border-transparent text-gray-500 hover:text-gray-200 hover:bg-vscode-sidebar-hover'
            }`}
         >
            <VscFiles size={24} />
         </div>
         <div 
            onClick={() => onTabClick('github')}
            className={`w-full h-[50px] flex items-center justify-center cursor-pointer border-l-2 transition-colors ${
               activeTab === 'github' ? 'border-vscode-accent text-gray-200' : 'border-transparent text-gray-500 hover:text-gray-200 hover:bg-vscode-sidebar-hover'
            }`}
         >
            <VscGithubAlt size={24} />
         </div>
         <div 
            onClick={() => onTabClick('projects')}
            className={`w-full h-[50px] flex items-center justify-center cursor-pointer border-l-2 transition-colors ${
               activeTab === 'projects' ? 'border-vscode-accent text-gray-200' : 'border-transparent text-gray-500 hover:text-gray-200 hover:bg-vscode-sidebar-hover'
            }`}
         >
            <VscCode size={24} />
         </div>
         <div className="w-full h-[50px] flex items-center justify-center cursor-pointer border-l-2 border-transparent text-gray-500 hover:text-gray-200 hover:bg-vscode-sidebar-hover transition-colors">
            <VscEdit size={24} />
         </div>
         <div 
            onClick={() => onTabClick('contact')}
            className={`w-full h-[50px] flex items-center justify-center cursor-pointer border-l-2 transition-colors ${
               activeTab === 'contact' ? 'border-vscode-accent text-gray-200' : 'border-transparent text-gray-500 hover:text-gray-200 hover:bg-vscode-sidebar-hover'
            }`}
         >
             <VscMail size={24} />
         </div>
      </div>

      <div className="flex flex-col w-full pb-2">
         <div className="w-full h-[50px] flex items-center justify-center cursor-pointer text-gray-500 hover:text-gray-200 hover:bg-vscode-sidebar-hover transition-colors">
            <VscAccount size={24} />
         </div>
         <div className="w-full h-[50px] flex items-center justify-center cursor-pointer text-gray-500 hover:text-gray-200 hover:bg-vscode-sidebar-hover transition-colors">
            <VscSettings size={24} />
         </div>
      </div>
    </aside>
  );
};

export default ActivityBar;
