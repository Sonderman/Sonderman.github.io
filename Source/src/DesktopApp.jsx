import VSCodeLayout from './components/VSCode/VSCodeLayout';
import PhoneFrame from './components/Android/PhoneFrame';
import TabletFrame from './components/Tablet/TabletFrame';
import ScalableWrapper from './components/common/ScalableWrapper';

function App() {
  return (
    <div className="w-full h-full bg-[#121212] overflow-y-auto p-8 flex flex-col items-center gap-16 pb-32">
      {/* Header / Intro */}
      <div className="text-center space-y-6 pt-16 mb-8">
        <h1 className="text-6xl md:text-8xl font-extrabold tracking-tighter text-transparent bg-clip-text bg-gradient-to-r from-blue-400 via-purple-500 to-pink-500 drop-shadow-2xl animate-fade-in-up">
          Hello, I'm Sonderman
        </h1>
        <p className="text-gray-400 text-xl md:text-2xl max-w-3xl mx-auto font-light leading-relaxed">
          Building immersive experiences in <span className="text-blue-400 font-medium">Web</span>, <span className="text-green-400 font-medium">Mobile</span>, and <span className="text-purple-400 font-medium">Games</span>.
        </p>
      </div>

      {/* Main Experience Section (VS Code + Android) */}
      <section className="w-full lg:max-w-[90%] flex flex-col lg:flex-row gap-8 items-start justify-center mt-10">
        {/* VS Code Container */}
        <div className="flex-grow min-w-0 w-full lg:w-auto aspect-video shadow-2xl shadow-blue-900/20 relative z-20">
          <ScalableWrapper referenceWidth={1280} referenceHeight={720}>
            <VSCodeLayout />
          </ScalableWrapper>
        </div>

        {/* Android Container */}
        <div className="flex flex-col items-center flex-shrink-0 w-full lg:w-[18%] min-w-[250px]">
          <h2 className="text-xl font-bold text-gray-300 mb-6 flex items-center">
            <span className="w-2 h-8 bg-green-500 rounded mr-3"></span>
            Mobile Experience
          </h2>
          <div className="w-full">
             <ScalableWrapper referenceWidth={320} referenceHeight={693}>
               <PhoneFrame />
             </ScalableWrapper>
          </div>
        </div>
      </section>

      {/* Game Experience Section (Tablet - Expanded) */}
      <section className="w-full max-w-7xl flex flex-col items-center mt-20">
        <h2 className="text-xl font-bold text-gray-300 mb-6 flex items-center self-start md:ml-12">
          <span className="w-2 h-8 bg-purple-500 rounded mr-3"></span>
          Game Experience
        </h2>
        <div className="w-full">
          <TabletFrame />
        </div>
      </section>

    </div>
  );
}

export default App;
