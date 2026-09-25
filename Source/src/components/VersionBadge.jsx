import { APP_VERSION_LABEL } from '../version';

// Sayfanin sag alt kosesindeki surum etiketi. pointer-events-none sayesinde
// altindaki baglantilara tiklamayi engellemez, olay dinleyicisi tutmaz.
const VersionBadge = () => (
  <span className="fixed bottom-2 right-3 z-50 select-none pointer-events-none text-[10px] tracking-wide text-white/35">
    {APP_VERSION_LABEL}
  </span>
);

export default VersionBadge;
