import React, { useEffect, useRef, useState } from 'react';
import { VscClose, VscScreenFull, VscScreenNormal } from 'react-icons/vsc';

const UnityWebGLPlayer = ({ gamePath, gameName, onClose }) => {
  const canvasRef = useRef(null);
  const containerRef = useRef(null);
  const unityInstanceRef = useRef(null);
  const [isLoading, setIsLoading] = useState(true);
  const [loadingProgress, setLoadingProgress] = useState(0);
  const [error, setError] = useState(null);
  const [isPlaying, setIsPlaying] = useState(false);
  const [isFullscreen, setIsFullscreen] = useState(false);

  const handlePlayClick = () => {
    setIsPlaying(true);
    loadUnityGame();
  };

  const loadUnityGame = async () => {
    try {
      setIsLoading(true);
      setError(null);

      // Dynamically load the Unity loader script from public folder
      const loaderPath = `/games/${gamePath}/Build/Web.loader.js`;
      
      // Check if the loader is already loaded
      if (!window.createUnityInstance) {
        const script = document.createElement('script');
        script.src = loaderPath;
        script.async = true;
        
        script.onerror = () => {
          setError('Failed to load Unity loader script');
          setIsLoading(false);
        };

        script.onload = () => {
          initializeUnityInstance();
        };

        document.body.appendChild(script);
      } else {
        initializeUnityInstance();
      }
    } catch (err) {
      setError(err.message);
      setIsLoading(false);
    }
  };

  // Track mounted state to handle async loading cleanup
  const isMountedRef = useRef(true);

  useEffect(() => {
    isMountedRef.current = true;
    return () => { isMountedRef.current = false; };
  }, []);

  const initializeUnityInstance = () => {
    if (!canvasRef.current || !window.createUnityInstance) {
      setError('Unity canvas or loader not available');
      setIsLoading(false);
      return;
    }

    const canvas = canvasRef.current;
    const buildPath = `/games/${gamePath}/Build`;

    console.log('Unity initialization started');
    console.log('Build path:', buildPath);
    console.log('Canvas:', canvas);
    console.log('createUnityInstance available:', !!window.createUnityInstance);

    window.createUnityInstance(canvas, {
      dataUrl: `${buildPath}/Web.data.unityweb`,
      frameworkUrl: `${buildPath}/Web.framework.js.unityweb`,
      codeUrl: `${buildPath}/Web.wasm.unityweb`,
      streamingAssetsUrl: "StreamingAssets",
      companyName: "Sondermium",
      productName: gameName,
      productVersion: "1.0",
    }, (progress) => {
      console.log('Loading progress:', progress);
      if (isMountedRef.current) {
        setLoadingProgress(Math.round(progress * 100));
      }
    })
    .then((unityInstance) => {
      console.log('Unity instance created successfully:', unityInstance);
      
      // If component unmounted while loading, quit immediately
      if (!isMountedRef.current) {
        console.log('Component unmounted during load, quitting instance immediately');
        unityInstance.Quit().catch(e => console.error('Immediate quit error:', e));
        return;
      }

      unityInstanceRef.current = unityInstance;
      setIsLoading(false);
    })
    .catch((err) => {
      console.error('Unity initialization error:', err);
      if (isMountedRef.current) {
        setError(`Failed to initialize Unity: ${err?.message || err || 'Unknown error'}`);
        setIsLoading(false);
      }
    });
  };

  const toggleFullscreen = () => {
    if (!document.fullscreenElement) {
      containerRef.current?.requestFullscreen();
      setIsFullscreen(true);
    } else {
      document.exitFullscreen();
      setIsFullscreen(false);
    }
  };

  useEffect(() => {
    const handleFullscreenChange = () => {
      setIsFullscreen(!!document.fullscreenElement);
    };

    document.addEventListener('fullscreenchange', handleFullscreenChange);
    return () => {
      document.removeEventListener('fullscreenchange', handleFullscreenChange);
    };
  }, []);

  const handleClose = async () => {
    if (unityInstanceRef.current) {
      try {
        console.log('Quitting Unity instance...');
        await unityInstanceRef.current.Quit();
        console.log('Unity instance quit successfully');
        unityInstanceRef.current = null;
      } catch (e) {
        console.error('Error during Unity quit:', e);
      }
    }

    // Deep Cleanup: Remove loader script and global instance
    // This ensures no conflict between different games/versions and frees memory
    try {
      if (window.createUnityInstance) {
        window.createUnityInstance = null;
      }
      
      const loaderScript = document.querySelector(`script[src*="${gamePath}/Build/Web.loader.js"]`);
      if (loaderScript) {
        loaderScript.remove();
        console.log('Unity loader script removed');
      }
    } catch (e) {
      console.warn('Error during script cleanup:', e);
    }

    onClose();
  };

  useEffect(() => {
    // Cleanup on unmount (fallback if unmounted without handleClose)
    return () => {
      if (unityInstanceRef.current) {
        console.log('Running fallback cleanup...');
        try {
          unityInstanceRef.current.Quit().catch(e => console.error('Fallback quit error:', e));
        } catch (e) {
          console.error('Error during Unity fallback cleanup:', e);
        }
      }
      
      // Fallback script cleanup
      if (window.createUnityInstance) {
        window.createUnityInstance = null;
      }
    };
  }, [gamePath]); // Add dependency to ensure cleanup runs if path changes

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/90 backdrop-blur-sm animate-fadeIn">
      <div 
        ref={containerRef}
        className="relative tablet-frame"
      >
        {/* Header Controls */}
        <div className="absolute top-4 right-4 z-10 flex gap-2">
          <button
            onClick={toggleFullscreen}
            className="p-2 bg-black/50 hover:bg-black/70 text-white rounded-lg backdrop-blur-md transition-all"
            title={isFullscreen ? "Exit Fullscreen" : "Fullscreen"}
          >
            {isFullscreen ? <VscScreenNormal size={20} /> : <VscScreenFull size={20} />}
          </button>
          <button
            onClick={handleClose}
            className="p-2 bg-black/50 hover:bg-red-600/80 text-white rounded-lg backdrop-blur-md transition-all"
            title="Close"
          >
            <VscClose size={20} />
          </button>
        </div>

        {/* Tablet Device Frame */}
        <div className="tablet-device">
          <div className="tablet-screen">
            {!isPlaying ? (
              // Play Button Overlay
              <div className="absolute inset-0 flex flex-col items-center justify-center bg-gradient-to-br from-purple-600 via-purple-700 to-blue-600 text-white">
                <h1 className="text-3xl font-bold mb-4">Unity WebGL Game</h1>
                <p className="text-gray-200 mb-8 max-w-md text-center px-4">
                  This is where your Unity WebGL build will run. Currently running in simulation mode.
                </p>
                <button
                  onClick={handlePlayClick}
                  className="px-8 py-3 bg-blue-500 hover:bg-blue-600 text-white font-semibold rounded-lg shadow-lg transition-all transform hover:scale-105 active:scale-95"
                >
                  Play Game
                </button>
              </div>
            ) : (
              <>
                {/* Unity Canvas */}
                <canvas
                  ref={canvasRef}
                  id="unity-canvas"
                  width={960}
                  height={600}
                  className="w-full h-full"
                  style={{ background: '#231F20' }}
                />

                {/* Loading Overlay */}
                {isLoading && (
                  <div className="absolute inset-0 flex flex-col items-center justify-center bg-gradient-to-br from-purple-600/95 via-purple-700/95 to-blue-600/95 text-white">
                    <div className="flex flex-col items-center gap-4">
                      <div className="loading-spinner"></div>
                      <p className="text-xl font-semibold">Loading Game...</p>
                      <div className="w-64 h-2 bg-white/20 rounded-full overflow-hidden">
                        <div 
                          className="h-full bg-blue-400 transition-all duration-300"
                          style={{ width: `${loadingProgress}%` }}
                        />
                      </div>
                      <p className="text-sm text-gray-200">{loadingProgress}%</p>
                    </div>
                  </div>
                )}

                {/* Error Overlay */}
                {error && (
                  <div className="absolute inset-0 flex flex-col items-center justify-center bg-red-900/90 text-white p-8">
                    <h2 className="text-2xl font-bold mb-4">Error Loading Game</h2>
                    <p className="text-center mb-6">{error}</p>
                    <button
                      onClick={handleClose}
                      className="px-6 py-2 bg-white text-red-900 rounded-lg font-semibold hover:bg-gray-100 transition-all"
                    >
                      Close
                    </button>
                  </div>
                )}
              </>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default UnityWebGLPlayer;
