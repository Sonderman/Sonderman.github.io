import React, { useState, useRef, useEffect } from 'react';
import { projects } from '../../data/projects';
import { VscHome, VscLoading, VscChevronLeft, VscChevronRight } from 'react-icons/vsc';

const UnityContainer = () => {
  const [activeGame, setActiveGame] = useState(null);
  const [isLoading, setIsLoading] = useState(false);
  const [loadingProgress, setLoadingProgress] = useState(0);
  const [error, setError] = useState(null);
  const [hoveredIdx, setHoveredIdx] = useState(null);
  
  const canvasRef = useRef(null);
  const unityInstanceRef = useRef(null);
  const isMountedRef = useRef(true);
  const scrollRef = useRef(null);

  // Filter playable games from projects
  const games = projects.filter(p => p.playableAssetPath);

  useEffect(() => {
    isMountedRef.current = true;
    return () => { isMountedRef.current = false; };
  }, []);

  useEffect(() => {
    return () => {
      cleanupUnity();
    };
  }, [activeGame]);

  const cleanupUnity = async () => {
    if (unityInstanceRef.current) {
        try {
            await unityInstanceRef.current.Quit();
        } catch (e) {
            console.error('Error quitting Unity:', e);
        }
        unityInstanceRef.current = null;
    }

    try {
        if (window.createUnityInstance) {
            window.createUnityInstance = null;
        }
        if (activeGame) {
             const loaderScript = document.querySelector(`script[src*="${activeGame.playableAssetPath}/Build/Web.loader.js"]`);
             if (loaderScript) loaderScript.remove();
        }
    } catch (e) {
        console.warn('Cleanup error:', e);
    }
  };

  const loadGame = (game) => {
    setActiveGame(game);
    setIsLoading(true);
    setLoadingProgress(0);
    setError(null);
    setTimeout(() => initializeUnity(game), 100);
  };

  const initializeUnity = (game) => {
    const loaderPath = `/games/${game.playableAssetPath}/Build/Web.loader.js`;

    if (!document.querySelector(`script[src="${loaderPath}"]`)) {
        const script = document.createElement('script');
        script.src = loaderPath;
        script.async = true;
        script.onload = () => createInstance(game);
        script.onerror = () => {
            setError("Failed to load game engine.");
            setIsLoading(false);
        };
        document.body.appendChild(script);
    } else {
        createInstance(game);
    }
  };

  const createInstance = (game) => {
    if (!canvasRef.current || !window.createUnityInstance) return;
    const buildPath = `/games/${game.playableAssetPath}/Build`;
    window.createUnityInstance(canvasRef.current, {
        dataUrl: `${buildPath}/Web.data.unityweb`,
        frameworkUrl: `${buildPath}/Web.framework.js.unityweb`,
        codeUrl: `${buildPath}/Web.wasm.unityweb`,
        streamingAssetsUrl: "StreamingAssets",
        companyName: "Sondermium",
        productName: game.title,
        productVersion: "1.0",
        devicePixelRatio: window.devicePixelRatio || 1,
    }, (progress) => {
        if (isMountedRef.current) setLoadingProgress(Math.round(progress * 100));
    })
    .then((instance) => {
        if (isMountedRef.current) {
            unityInstanceRef.current = instance;
            setIsLoading(false);
        } else {
            instance.Quit();
        }
    })
    .catch((err) => {
        if (isMountedRef.current) {
            setError("Game failed to start: " + err);
            setIsLoading(false);
        }
    });
  };

  const handleHomeClick = async () => {
    await cleanupUnity();
    setActiveGame(null);
    setError(null);
  };

  const scroll = (direction) => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const scrollTo = direction === 'left' ? scrollLeft - 300 : scrollLeft + 300;
      scrollRef.current.scrollTo({ left: scrollTo, behavior: 'smooth' });
    }
  };

  return (
    <div className="w-full h-full bg-[#050505] overflow-hidden relative font-sans select-none flex flex-col items-center justify-center">
        
        {/* Animated Background - Console Style */}
        <div className={`absolute inset-0 transition-opacity duration-1000 ${activeGame ? 'opacity-0' : 'opacity-100'}`}>
            <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-blue-600/20 blur-[120px] rounded-full animate-pulse"></div>
            <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-purple-600/20 blur-[120px] rounded-full animate-pulse delay-700"></div>
        </div>

        {/* Top Info Bar */}
        {!activeGame && (
            <div className="absolute top-0 left-0 w-full p-[3cqw] flex justify-between items-center z-20 text-white/40">
                <div className="flex items-center gap-[1.5cqw]">
                    <div className="w-[4cqw] h-[4cqw] rounded-full bg-gradient-to-tr from-white/10 to-white/5 border border-white/10 flex items-center justify-center">
                        <span className="text-[1.5cqw] font-bold text-white/60">S</span>
                    </div>
                    <span className="text-[2.2cqw] font-medium tracking-widest uppercase">Sondermium OS</span>
                </div>
                <div className="flex items-center gap-[2cqw] text-[1.8cqw] font-mono">
                    <span>{new Date().getHours()}:{new Date().getMinutes().toString().padStart(2, '0')}</span>
                    <div className="flex gap-[0.6cqw]">
                        <div className="w-[1.2cqw] h-[1.2cqw] border border-white/20 rounded-sm"></div>
                        <div className="w-[1.2cqw] h-[2cqw] border border-white/20 rounded-sm bg-white/40"></div>
                    </div>
                </div>
            </div>
        )}

        <div className="relative z-10 w-full h-full flex flex-col justify-center">
            {!activeGame ? (
                /* --- DASHBOARD SCREEN --- */
                <div className="w-full h-full flex flex-col justify-center animate-fadeIn">
                    
                    {/* Game Previews and Selection */}
                    <div className="relative w-full px-[4cqw] group/carousel">
                        <div 
                            ref={scrollRef}
                            className="flex gap-[2cqw] overflow-x-auto no-scrollbar py-[4cqw] px-[1cqw] scroll-smooth"
                            style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
                        >
                            {games.map((game, idx) => (
                                <button 
                                    key={idx}
                                    onClick={() => loadGame(game)}
                                    onMouseEnter={() => setHoveredIdx(idx)}
                                    onMouseLeave={() => setHoveredIdx(null)}
                                    className={`relative flex-shrink-0 transition-all duration-300 transform 
                                        ${hoveredIdx === idx ? 'scale-110 -translate-y-[2cqh]' : 'scale-100'} 
                                        active:scale-95`}
                                >
                                    <div 
                                        className={`rounded-[2cqw] overflow-hidden border-2 transition-all duration-300 shadow-2xl
                                            ${hoveredIdx === idx ? 'border-blue-400 shadow-blue-500/30' : 'border-white/10'}`}
                                        style={{ width: '22cqw', height: '30cqw' }}
                                    >
                                        {game.images && game.images.length > 0 ? (
                                            <img 
                                                src={`/src/assets/projects/${game.images[0]}`} 
                                                alt={game.title} 
                                                className="w-full h-full object-cover"
                                            />
                                        ) : (
                                            <div className="w-full h-full bg-gradient-to-tr from-[#111] to-[#222]"></div>
                                        )}
                                        {/* Overlay gradient */}
                                        <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-60"></div>
                                        
                                        {/* Title on card */}
                                        <div className="absolute bottom-[2cqw] left-[2cqw] right-[2cqw]">
                                            <div className="text-[1cqw] text-blue-400 font-bold uppercase tracking-widest mb-[0.4cqw]">Playable</div>
                                            <div className="text-white text-[2cqw] font-bold truncate">{game.title}</div>
                                        </div>
                                    </div>
                                    
                                    {/* Selection Glow */}
                                    {hoveredIdx === idx && (
                                        <div className="absolute -inset-[1.5cqw] bg-blue-500/20 blur-[2.5cqw] -z-10 rounded-[3.5cqw] animate-pulse"></div>
                                    )}
                                </button>
                            ))}
                        </div>

                        {/* Carousel Navigation */}
                        <button 
                            onClick={() => scroll('left')}
                            className="absolute left-[2cqw] top-1/2 -translate-y-1/2 w-[5cqw] h-[5cqw] rounded-full bg-black/50 border border-white/10 flex items-center justify-center text-white opacity-0 group-hover/carousel:opacity-100 transition-opacity hover:bg-black"
                        >
                            <VscChevronLeft size="3cqw" />
                        </button>
                        <button 
                            onClick={() => scroll('right')}
                            className="absolute right-[2cqw] top-1/2 -translate-y-1/2 w-[5cqw] h-[5cqw] rounded-full bg-black/50 border border-white/10 flex items-center justify-center text-white opacity-0 group-hover/carousel:opacity-100 transition-opacity hover:bg-black"
                        >
                            <VscChevronRight size="3cqw" />
                        </button>
                    </div>

                    {/* Hint Text */}
                    <div className="px-[6cqw] mt-[3cqw] flex justify-between items-center text-white/40 text-[1.8cqw] tracking-widest uppercase font-medium">
                        <div className="flex gap-[3cqw]">
                            <span>(A) Select</span>
                            <span>(B) Back</span>
                        </div>
                        <div className="flex gap-[3cqw]">
                            <span>Library</span>
                            <span>Options</span>
                        </div>
                    </div>
                </div>
            ) : (
                /* --- GAME SCREEN --- */
                <div className="w-full h-full relative">
                    <canvas ref={canvasRef} id="unity-canvas" className="w-full h-full block" />

                    {isLoading && (
                        <div className="absolute inset-0 flex flex-col items-center justify-center bg-black/90 backdrop-blur-md z-20">
                            <div className="relative w-[12cqw] h-[12cqw] mb-[3cqw]">
                                <div className="absolute inset-0 border-[0.6cqw] border-blue-500/20 rounded-full"></div>
                                <div className="absolute inset-0 border-[0.6cqw] border-blue-500 border-t-transparent rounded-full animate-spin"></div>
                                <div className="absolute inset-0 flex items-center justify-center text-blue-400 font-mono font-bold text-[2cqw]">
                                    {loadingProgress}%
                                </div>
                            </div>
                            <div className="text-white/40 text-[1.5cqw] tracking-[0.3em] uppercase animate-pulse">Initializing Subsystem...</div>
                        </div>
                    )}

                    {error && (
                        <div className="absolute inset-0 flex flex-col items-center justify-center bg-red-950/90 z-30 p-[5cqw] text-center text-white">
                            <h3 className="text-[2.5cqw] font-bold mb-[1cqw]">System Error</h3>
                            <p className="mb-[3cqw] opacity-60 text-[1.5cqw] max-w-[50cqw]">{error}</p>
                            <button onClick={handleHomeClick} className="px-[4cqw] py-[1.5cqw] bg-white text-black rounded-full font-bold text-[1.5cqw] hover:bg-gray-200 transition-colors">
                                Return to Dashboard
                            </button>
                        </div>
                    )}

                    {/* Exit Hint */}
                    <div className="absolute bottom-[3cqw] left-1/2 -translate-x-1/2 z-20">
                        <button 
                            onClick={handleHomeClick}
                            className="bg-black/50 hover:bg-white text-white hover:text-black w-[5cqw] h-[5cqw] rounded-full backdrop-blur-md transition-all flex items-center justify-center border border-white/10 shadow-lg"
                            title="Exit"
                        >
                            <VscHome size="2.5cqw" />
                        </button>
                    </div>
                </div>
            )}
        </div>
    </div>
  );
};

export default UnityContainer;

