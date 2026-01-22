import React, { useState } from 'react';
import Titlebar from './Titlebar';
import ActivityBar from './ActivityBar';
import Explorer from './Explorer';
import Tabsbar from './Tabsbar';
import Bottombar from './Bottombar';
import EditorWindow from './EditorWindow';
import GithubPreview from './GithubPreview';
import ProjectsPreview from './ProjectsPreview';
import ContactPreview from './ContactPreview';
import { files } from '../../data/files';

const VSCodeLayout = () => {
  const [openFiles, setOpenFiles] = useState([files[0]]);
  const [activeFile, setActiveFile] = useState(files[0]);
  const [activeTab, setActiveTab] = useState('files');

  const handleFileClick = (file) => {
    setActiveTab('files');
    if (!openFiles.find((f) => f.name === file.name)) {
      setOpenFiles([...openFiles, file]);
    }
    setActiveFile(file);
  };

  const handleCloseFile = (fileToClose) => {
    const newOpenFiles = openFiles.filter((f) => f.name !== fileToClose.name);
    setOpenFiles(newOpenFiles);
    
    if (activeFile?.name === fileToClose.name) {
      if (newOpenFiles.length > 0) {
        setActiveFile(newOpenFiles[newOpenFiles.length - 1]);
      } else {
        setActiveFile(null);
      }
    }
  };

  return (
    <div className="w-full h-full flex flex-col bg-vscode-bg text-vscode-text shadow-2xl rounded-lg overflow-hidden border border-[#333] font-sans">
       <Titlebar />
       
       <div className="flex-1 flex overflow-hidden">
          <ActivityBar 
             activeTab={activeTab} 
             onTabClick={(tab) => {
                setActiveTab(tab);
             }} 
          />
          
          {activeTab === 'files' && <Explorer files={files} activeFile={activeFile} onFileClick={handleFileClick} />}
          
          <div className="flex-1 flex flex-col min-w-0 bg-vscode-bg">
             {activeTab === 'files' && (
                <Tabsbar 
                   openFiles={openFiles} 
                   activeFile={activeFile} 
                   onCloseFile={handleCloseFile}
                   onSetActiveFile={setActiveFile}
                />
             )}
             <div className="flex-1 overflow-hidden relative">
                  {activeTab === 'github' && <GithubPreview />}
                  {activeTab === 'projects' && <ProjectsPreview />}
                  {activeTab === 'contact' && <ContactPreview />}
                  {activeTab === 'files' && (
                    <EditorWindow 
                      openFiles={openFiles}
                      activeFile={activeFile} 
                      onCloseFile={handleCloseFile}
                      onSetActiveFile={setActiveFile}
                    />
                  )}
             </div>
          </div>
       </div>

       <Bottombar />
    </div>
  );
};

export default VSCodeLayout;
