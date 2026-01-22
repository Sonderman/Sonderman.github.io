import React, { useState, useEffect } from 'react';
import ReactMarkdown from 'react-markdown';
import rehypeRaw from 'rehype-raw';
import { VscGithubInverted, VscStarFull, VscRepoForked, VscEye } from 'react-icons/vsc';
import { motion } from 'framer-motion';

const GithubPreview = () => {
  const [readme, setReadme] = useState('');
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [repoInfo, setRepoInfo] = useState(null);

  useEffect(() => {
    const fetchGithubData = async () => {
      try {
        setLoading(true);
        // Fetch README
        const readmeRes = await fetch('https://raw.githubusercontent.com/Sonderman/Sonderman/master/README.md');
        if (!readmeRes.ok) throw new Error('Failed to fetch README');
        const readmeText = await readmeRes.text();
        setReadme(readmeText);

        // Fetch Profile Info
        const userRes = await fetch('https://api.github.com/users/Sonderman');
        if (userRes.ok) {
          const userData = await userRes.json();
          setRepoInfo(userData);
        }
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchGithubData();
  }, []);

  if (loading) {
    return (
      <div className="w-full h-full flex items-center justify-center bg-vscode-bg text-gray-500">
        <div className="flex flex-col items-center">
          <div className="w-8 h-8 border-2 border-vscode-accent border-t-transparent rounded-full animate-spin mb-4"></div>
          <span className="animate-pulse">Fetching README from GitHub...</span>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="w-full h-full flex items-center justify-center bg-vscode-bg">
        <div className="bg-red-900/20 text-red-400 p-6 rounded-lg max-w-md text-center border border-red-900/50">
          <div className="text-xl font-bold mb-2">Failed to load README</div>
          <p className="text-sm opacity-80">{error}</p>
        </div>
      </div>
    );
  }

  return (
    <motion.div 
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      className="w-full h-full overflow-y-auto custom-scrollbar bg-vscode-bg"
    >
      <div className="max-w-4xl mx-auto p-8 md:p-12">
        {/* GitHub Header Section */}
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-6 pb-8 mb-8 border-b border-gray-700/50">
          <div className="flex items-center space-x-4">
            <div className="w-16 h-16 rounded-full overflow-hidden border-2 border-vscode-accent/50 shadow-lg">
              <img src="https://github.com/Sonderman.png" alt="Avatar" className="w-full h-full object-cover" />
            </div>
            <div>
              <h1 className="text-2xl font-bold text-white mb-1">Sonderman</h1>
              <p className="text-gray-400">@Sonderman / README.md</p>
            </div>
          </div>

          <div className="flex items-center gap-4">
             {repoInfo && (
                <div className="flex items-center gap-4 text-sm text-gray-300 bg-gray-800/50 px-4 py-2 rounded-full border border-gray-700/50 shadow-sm">
                  <div className="flex items-center gap-1.5 cursor-default group" title="Followers">
                    <VscEye className="text-vscode-accent group-hover:scale-110 transition-transform" />
                    <span>{repoInfo.followers} followers</span>
                  </div>
                  <div className="h-4 w-[1px] bg-gray-700"></div>
                  <div className="flex items-center gap-1.5 cursor-default group" title="Public Repositories">
                    <VscRepoForked className="text-blue-400 group-hover:scale-110 transition-transform" />
                    <span>{repoInfo.public_repos} repos</span>
                  </div>
                </div>
             )}
            <a 
              href="https://github.com/Sonderman" 
              target="_blank" 
              rel="noopener noreferrer"
              className="flex items-center space-x-2 bg-[#2ea44f] hover:bg-[#2c974b] text-white px-5 py-2 rounded-md text-[13px] font-bold shadow-md transition-all active:scale-95"
            >
              <VscGithubInverted size={18} />
              <span>Follow</span>
            </a>
          </div>
        </div>

        {/* README Content */}
        <div className="github-markdown-preview prose prose-invert prose-md max-w-none">
          <style dangerouslySetInnerHTML={{ __html: `
            .github-markdown-preview img[align="left"] { margin-right: 1.5rem; margin-bottom: 1rem; float: left; clear: left; }
            .github-markdown-preview img[align="right"] { margin-left: 1.5rem; margin-bottom: 1rem; float: right; clear: right; }
            .github-markdown-preview p { clear: none; }
            .github-markdown-preview h1, .github-markdown-preview h2, .github-markdown-preview h3 { clear: both; }
            .github-markdown-preview br[clear="both"] { clear: both; display: block; content: ""; height: 0; }
          `}} />
          <ReactMarkdown 
            rehypePlugins={[rehypeRaw]}
            components={{
              img: ({node, ...props}) => {
                const src = props.src || '';
                const isBadge = src.includes('badge') || src.includes('visitor-badge');
                const isIcon = src.includes('devicon') || src.includes('skillicons.dev') || src.includes('get-icon') || 
                               src.includes('simpleicons.org') || src.includes('flutter') || src.includes('dart') || 
                               src.includes('react') || src.includes('javascript') || src.includes('unity') || 
                               src.includes('csharp') || src.includes('android') || src.includes('firebase') ||
                               src.includes('gmail') || src.includes('linkedin');
                
                const align = node.properties?.align;
                const height = node.properties?.height;

                if (isBadge || isIcon) {
                   return (
                    <img 
                      {...props} 
                      className={`inline-block my-1 mx-0.5 rounded align-middle`}
                      style={{ 
                          height: height ? `${height}px` : (isIcon ? '32px' : '20px'),
                          maxHeight: height ? `${height}px` : (isIcon ? '32px' : '20px'),
                          display: 'inline-block',
                          width: 'auto',
                      }}
                    />
                  );
                }

                return (
                  <img 
                    {...props} 
                    className={`max-w-full h-auto object-contain rounded-lg my-4 ${align === 'left' ? 'float-left mr-6' : align === 'right' ? 'float-right ml-6' : 'mx-auto block clear-both'}`}
                    style={{ 
                        maxHeight: height ? `${height}px` : '180px',
                        maxWidth: align ? '150px' : '100%',
                    }}
                  />
                );
              },
              h1: ({node, ...props}) => <h1 {...props} className="text-3xl font-extrabold mb-6 pb-2 border-b border-gray-700 mt-8 first:mt-0" />,
              h2: ({node, ...props}) => <h2 {...props} className="text-xl font-bold mb-4 mt-10 pb-1 border-b border-gray-800" />,
              p: ({node, ...props}) => <p {...props} className="mb-4 text-gray-300 leading-relaxed" />,
              ul: ({node, ...props}) => <ul {...props} className="list-disc pl-6 mb-4 space-y-2 text-gray-300" />,
              li: ({node, ...props}) => <li {...props} className="leading-relaxed" />,
              a: ({node, ...props}) => <a {...props} className="text-vscode-accent hover:underline decoration-vscode-accent/30" target="_blank" rel="noopener noreferrer" />,
              code: ({node, inline, ...props}) => (
                <code {...props} className={`${inline ? 'bg-gray-800 px-1.5 py-0.5 rounded text-pink-400 text-[0.9em]' : 'block bg-gray-900/50 p-4 rounded-lg my-4 text-blue-300 overflow-x-auto border border-gray-800 font-mono text-sm'}`} />
              ),
              pre: ({node, ...props}) => <pre {...props} className="bg-transparent p-0 m-0" />,
              blockquote: ({node, ...props}) => <blockquote {...props} className="border-l-4 border-gray-700 pl-4 py-1 italic text-gray-400 mb-4 bg-gray-800/10 rounded-r" />,
              br: () => <br className="my-2" />,
            }}
          >
            {readme}
          </ReactMarkdown>
        </div>
      </div>
    </motion.div>
  );
};

export default GithubPreview;
