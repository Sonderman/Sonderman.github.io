import React, { useState } from 'react';
import { projects } from '../../data/projects';
import { VscGithubAlt, VscLinkExternal, VscDeviceMobile, VscWindow, VscPlay } from 'react-icons/vsc';
import { FaGooglePlay, FaApple } from 'react-icons/fa';
import UnityWebGLPlayer from './UnityWebGLPlayer';

const ProjectsPreview = () => {
  const [filter, setFilter] = useState('all');
  const [playingGame, setPlayingGame] = useState(null);

  const filteredProjects = filter === 'all' 
    ? projects 
    : projects.filter(p => p.type === filter);

  return (
    <div className="w-full h-full bg-[#1e1e1e] flex flex-col font-sans">
      {/* Header / Filter */}
      <div className="p-6 border-b border-[#333] flex justify-between items-center bg-[#252526]">
        <div>
          <h2 className="text-xl font-bold text-gray-200">Projects</h2>
          <p className="text-sm text-gray-400 mt-1">Showcasing my work in Mobile Apps and Games</p>
        </div>
        <div className="flex gap-2">
          {['all', 'app', 'game'].map((type) => (
            <button
              key={type}
              onClick={() => setFilter(type)}
              className={`px-4 py-1.5 rounded-full text-sm font-medium transition-all ${
                filter === type 
                  ? 'bg-vscode-accent text-white shadow-lg shadow-vscode-accent/20' 
                  : 'bg-[#333] text-gray-400 hover:bg-[#444] hover:text-gray-200'
              } capitalize`}
            >
              {type}s
            </button>
          ))}
        </div>
      </div>

      {/* Projects Grid - Adjusted for better spacing and scrolling */}
      <div className="flex-1 overflow-y-auto p-8 grid grid-cols-1 lg:grid-cols-2 gap-8 custom-scrollbar">
        {filteredProjects.map((project, index) => (
          <div 
            key={index} 
            className="group relative bg-[#2d2d2d] rounded-2xl overflow-hidden border border-[#3c3c3c] hover:border-vscode-accent/50 transition-all duration-500 flex flex-col hover:shadow-2xl hover:shadow-vscode-accent/10 min-h-[500px] flex-shrink-0"
          >
            {/* Project Image Banner - Forced height with non-shrink behavior */}
            <div 
              className="relative overflow-hidden bg-[#1a1a1a] flex-shrink-0 group/img" 
              style={{ height: '320px' }}
            >
               {project.images && project.images.length > 0 ? (
                 <img 
                    src={`/src/assets/projects/${project.images[0]}`} 
                    alt={project.title}
                    className="w-full h-full object-cover group-hover:scale-110 transition-transform duration-700 opacity-90 group-hover:opacity-100"
                 />
               ) : (
                 <div className="w-full h-full flex items-center justify-center bg-gradient-to-br from-[#3a3a3a] to-[#252526]">
                    {project.type === 'game' ? (
                      <VscWindow size={80} className="text-vscode-accent/10" />
                    ) : (
                      <VscDeviceMobile size={80} className="text-vscode-accent/10" />
                    )}
                 </div>
               )}
               <div className="absolute inset-0 bg-gradient-to-t from-[#2d2d2d] via-transparent to-transparent opacity-80 group-hover/img:opacity-40 transition-opacity"></div>
               
               {/* Platform Badges */}
               <div className="absolute top-4 right-4 flex gap-2">
                 {project.platforms.map(p => (
                   <span key={p} className="bg-vscode-bg/90 backdrop-blur-md px-3 py-1 rounded-full text-[10px] uppercase font-bold text-vscode-accent border border-vscode-accent/30 shadow-lg">
                     {p}
                   </span>
                 ))}
               </div>
            </div>

            {/* Content - Increased padding and breathing room */}
            <div className="p-6 flex-1 flex flex-col">
              <div className="flex justify-between items-start mb-3">
                <h3 className="text-xl font-bold text-gray-100 group-hover:text-vscode-accent transition-colors">
                  {project.title}
                </h3>
                <span className="text-xs text-gray-500 font-mono bg-[#1e1e1e] px-2 py-1 rounded">{project.createdDate}</span>
              </div>
              
              <p className="text-sm text-gray-400 leading-relaxed mb-6 flex-1">
                {project.description || "No description provided."}
              </p>

              {/* Game Actions */}
              {(project.playableAssetPath || (project.type === 'game' && project.githubLink)) && (
                <div className="flex gap-3 mb-4">
                  {project.playableAssetPath && (
                    <button
                      onClick={() => setPlayingGame(project)}
                      className="flex-1 px-4 py-3 bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-700 hover:to-blue-700 text-white font-semibold rounded-lg shadow-lg transition-all transform hover:scale-105 active:scale-95 flex items-center justify-center gap-2"
                    >
                      <VscPlay size={20} />
                      <span>Play Game</span>
                    </button>
                  )}
                  {project.type === 'game' && project.githubLink && (
                    <a
                      href={project.githubLink}
                      target="_blank"
                      rel="noopener noreferrer"
                      className="flex-1 px-4 py-3 bg-[#3c3c3c] hover:bg-[#4c4c4c] text-white font-semibold rounded-lg shadow-lg transition-all transform hover:scale-105 active:scale-95 flex items-center justify-center gap-2 border border-[#555]"
                    >
                      <VscGithubAlt size={20} />
                      <span>Source</span>
                    </a>
                  )}
                </div>
              )}

              {/* Links - More prominent */}
              <div className="flex items-center gap-6 mt-auto pt-5 border-t border-[#3c3c3c]">
                {project.githubLink && (
                  <a 
                    href={project.githubLink} 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="text-gray-400 hover:text-vscode-accent transition-all flex items-center gap-2 text-sm font-medium group/link"
                  >
                    <VscGithubAlt size={20} className="group-hover/link:rotate-12 transition-transform" />
                    <span>View Source</span>
                  </a>
                )}
                {project.storeLinks && project.storeLinks.map((link, idx) => (
                   <a 
                    key={idx}
                    href={link} 
                    target="_blank" 
                    rel="noopener noreferrer"
                    className="text-gray-400 hover:text-vscode-accent transition-all flex items-center gap-2 text-sm font-medium"
                  >
                    {link.includes('play.google.com') ? <FaGooglePlay size={18} /> : <FaApple size={18} />}
                    <span>{link.includes('play.google.com') ? 'Play Store' : 'App Store'}</span>
                  </a>
                ))}
                {!project.githubLink && !project.storeLinks && (
                   <span className="text-gray-600 text-[11px] italic tracking-wide">Private Repository</span>
                )}
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Unity WebGL Player Modal */}
      {playingGame && (
        <UnityWebGLPlayer
          gamePath={playingGame.playableAssetPath}
          gameName={playingGame.title}
          onClose={() => setPlayingGame(null)}
        />
      )}
    </div>
  );
};

export default ProjectsPreview;
