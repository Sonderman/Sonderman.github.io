import React from 'react';
import ReactMarkdown from 'react-markdown';
import rehypeRaw from 'rehype-raw';
import HTMLRenderer from './HTMLRenderer';
import PDFRenderer from './PDFRenderer';
import SkillsPreview from './SkillsPreview';
import { motion } from 'framer-motion';

// Updated to remove internal Tab bar since we have a dedicated Tabsbar component now
const EditorWindow = ({ activeFile }) => {
  if (!activeFile) {
    return (
      <div className="w-full h-full flex flex-col items-center justify-center text-vscode-text/40 bg-vscode-bg relative overflow-hidden">
        {/* Large background logo */}
        <div 
          className="absolute inset-0 flex items-center justify-center opacity-[0.03] select-none pointer-events-none"
          style={{ transform: 'scale(1.5)' }}
        >
          <img src="/vsc.svg" alt="" className="w-1/2 max-w-xl" />
        </div>

        <div className="z-10 text-center space-y-8">
          <h2 className="text-xl font-medium tracking-wide text-gray-500/80">Visual Studio Code</h2>
          
          <div className="grid grid-cols-[1fr_auto] gap-x-8 gap-y-3 text-sm font-light">
             <div className="text-right text-gray-400/60">Show All Commands</div>
             <div className="text-left"><span className="bg-[#ffffff0a] border border-[#ffffff10] px-2 py-0.5 rounded text-xs text-gray-400">Ctrl + Shift + P</span></div>
             
             <div className="text-right text-gray-400/60">Go to File</div>
             <div className="text-left"><span className="bg-[#ffffff0a] border border-[#ffffff10] px-2 py-0.5 rounded text-xs text-gray-400">Ctrl + P</span></div>
             
             <div className="text-right text-gray-400/60">Find in Files</div>
             <div className="text-left"><span className="bg-[#ffffff0a] border border-[#ffffff10] px-2 py-0.5 rounded text-xs text-gray-400">Ctrl + Shift + F</span></div>

             <div className="text-right text-gray-400/60">Toggle Terminal</div>
             <div className="text-left"><span className="bg-[#ffffff0a] border border-[#ffffff10] px-2 py-0.5 rounded text-xs text-gray-400">Ctrl + `</span></div>
          </div>
        </div>
      </div>
    );
  }

   return (
    <div className="w-full h-full overflow-auto custom-scrollbar bg-vscode-bg p-0">
         {/* Breadcrumbs (Optional, matching VSCode look) */}
         <div className="h-6 flex items-center px-4 text-[11px] text-gray-400/80 bg-vscode-bg sticky top-0 z-10 select-none border-b border-[#2b2b2b]">
            <span className="hover:text-gray-200 cursor-pointer">src</span>
            <span className="mx-1.5 text-gray-600 font-light">&gt;</span>
            <span className="hover:text-gray-200 cursor-pointer">data</span>
            <span className="mx-1.5 text-gray-600 font-light">&gt;</span>
            <span className="hover:text-gray-200 cursor-pointer">{activeFile.name}</span>
         </div>
         
         {activeFile.name.endsWith('.html') ? (
            <div className="w-full h-[calc(100%-24px)]">
                <HTMLRenderer content={activeFile.content} />
            </div>
         ) : activeFile.name.endsWith('.pdf') ? (
            <div className="w-full h-[calc(100%-24px)]">
                <PDFRenderer url={activeFile.content} />
            </div>
         ) : activeFile.name === 'skills.js' ? (
             <SkillsPreview skills={activeFile.content} />
         ) : activeFile.name === 'about.md' ? (
             <div className="p-8 w-full flex flex-col items-center min-h-[calc(100%-24px)]">
                <motion.div
                  key={activeFile.name}
                  initial={{ opacity: 0, y: 5 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.1 }}
                  className="w-full max-w-3xl"
                >
                  <ReactMarkdown
                     rehypePlugins={[rehypeRaw]}
                     components={{
                            h1: ({node, ...props}) => <h1 className="text-3xl md:text-5xl font-bold text-vscode-accent text-center mb-2 mt-4 w-full" {...props} />,
                            h6: ({node, ...props}) => <h6 className="text-xl text-gray-400 font-normal text-center mb-12 block w-full" {...props} />,
                            h2: ({node, ...props}) => <h2 className="text-2xl font-semibold text-vscode-accent text-center mt-12 mb-4 w-full" {...props} />,
                            p: ({node, ...props}) => <p className="text-gray-300 leading-relaxed mb-6 text-lg text-center w-full" {...props} />,
                            a: ({node, ...props}) => <a className="text-vscode-accent hover:text-vscode-accent/80 hover:underline decoration-vscode-accent/30 transition-colors" {...props} />,
                            ul: ({node, ...props}) => <ul className="list-none space-y-2 text-gray-300 flex flex-col items-center w-full" {...props} />,
                            li: ({node, ...props}) => <li className="text-center w-full" {...props} />
                     }}
                  >
                    {activeFile.content}
                  </ReactMarkdown>
                </motion.div>
             </div>
         ) : activeFile.name === 'projects.md' ? (
            <div className="p-8 w-full flex flex-col items-center min-h-[calc(100%-24px)]">
                <motion.div
                  key={activeFile.name}
                  initial={{ opacity: 0, y: 5 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.1 }}
                  className="w-full max-w-4xl"
                >
                    <ReactMarkdown
                        rehypePlugins={[rehypeRaw]}
                        components={{
                            h1: ({node, ...props}) => <h1 className="text-4xl font-bold text-vscode-accent mb-8 border-b border-gray-700/50 pb-4" {...props} />,
                            h2: ({node, ...props}) => <h2 className="text-2xl font-semibold text-gray-200 mt-12 mb-6 flex items-center gap-3 after:content-[''] after:h-px after:flex-1 after:bg-gray-700/50" {...props} />,
                            h3: ({node, ...props}) => <h3 className="text-xl font-medium text-blue-400 mt-8 mb-2" {...props} />,
                            p: ({node, ...props}) => <p className="text-gray-400 leading-relaxed mb-4" {...props} />,
                            em: ({node, ...props}) => <span className="text-xs font-mono text-emerald-500 bg-emerald-500/10 px-2 py-0.5 rounded ml-2 align-middle" {...props} />,
                            ul: ({node, ...props}) => <ul className="flex flex-wrap gap-2 mb-8 ml-0 list-none" {...props} />,
                            li: ({node, ...props}) => <li className="inline-block" {...props} />,
                            a: ({node, ...props}) => (
                                <a 
                                    className="inline-flex items-center px-3 py-1 bg-gray-800 hover:bg-vscode-accent hover:text-white border border-gray-700 hover:border-vscode-accent rounded transition-all text-sm text-gray-300 no-underline"
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    {...props} 
                                />
                            )
                        }}
                    >
                        {activeFile.content}
                    </ReactMarkdown>
                </motion.div>
            </div>
         ) : (
             <div className="p-8 max-w-4xl mx-auto min-h-[calc(100%-24px)]">
                <motion.div
                  key={activeFile.name}
                  initial={{ opacity: 0, y: 5 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ duration: 0.1 }}
                  className="prose prose-invert max-w-none prose-sm md:prose-base prose-pre:bg-[#1e1e1e]"
                >
                  <ReactMarkdown rehypePlugins={[rehypeRaw]}>
                    {activeFile.content}
                  </ReactMarkdown>
                </motion.div>
             </div>
         )}
    </div>
  );
};

export default EditorWindow;
