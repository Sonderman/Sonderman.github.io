import React, { useSyncExternalStore } from 'react';
import DesktopApp from './DesktopApp';
import MobileApp from './mobile/MobileApp';

// 1024px is the default 'lg' breakpoint in Tailwind: below it we show the mobile view.
const DESKTOP_QUERY = '(min-width: 1024px)';

const desktopQuery = () => window.matchMedia(DESKTOP_QUERY);

const subscribeToBreakpoint = (onStoreChange) => {
  const query = desktopQuery();
  query.addEventListener('change', onStoreChange);
  return () => query.removeEventListener('change', onStoreChange);
};

// The snapshot is a primitive, so repeated reads never trigger an endless render loop.
const getIsDesktop = () => desktopQuery().matches;

function App() {
  const isDesktop = useSyncExternalStore(subscribeToBreakpoint, getIsDesktop);

  return isDesktop ? <DesktopApp /> : <MobileApp />;
}

export default App;
