import React, { useState, useEffect } from 'react';
import DesktopApp from './DesktopApp';
import MobileApp from './mobile/MobileApp';

function App() {
  const [isMobile, setIsMobile] = useState(window.innerWidth < 1024);

  useEffect(() => {
    const checkMobile = () => {
      // 1024px is the default 'lg' breakpoint in Tailwind.
      // Below this width, we show the mobile-optimized view.
      setIsMobile(window.innerWidth < 1024);
    };

    // Initial check
    checkMobile();

    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  return isMobile ? <MobileApp /> : <DesktopApp />;
}

export default App;
