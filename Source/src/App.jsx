import React, { useState, useEffect } from 'react';
import DesktopApp from './DesktopApp';
import MobileApp from './mobile/MobileApp';

// 1024px is the default 'lg' breakpoint in Tailwind: below it we show the mobile view.
const DESKTOP_QUERY = '(min-width: 1024px)';

function App() {
  const [isMobile, setIsMobile] = useState(() => !window.matchMedia(DESKTOP_QUERY).matches);

  useEffect(() => {
    const mediaQuery = window.matchMedia(DESKTOP_QUERY);
    const handleChange = (event) => setIsMobile(!event.matches);

    // Sync once on mount, then react only to actual breakpoint crossings.
    setIsMobile(!mediaQuery.matches);
    mediaQuery.addEventListener('change', handleChange);
    return () => mediaQuery.removeEventListener('change', handleChange);
  }, []);

  return isMobile ? <MobileApp /> : <DesktopApp />;
}

export default App;
