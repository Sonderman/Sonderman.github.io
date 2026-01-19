import Hero from './components/Hero';
import Projects from './components/Projects';
import About from './components/About';
import Contact from './components/Contact';
import { motion, useScroll, useSpring } from 'framer-motion';

function App() {
  const { scrollYProgress } = useScroll();
  const scaleX = useSpring(scrollYProgress, {
    stiffness: 100,
    damping: 30,
    restDelta: 0.001
  });

  return (
    <div className="bg-slate-950 min-h-screen text-slate-100 selection:bg-blue-500 selection:text-white">
      {/* Progress Bar */}
      <motion.div
        className="fixed top-0 left-0 right-0 h-1 bg-gradient-to-r from-blue-500 to-purple-500 origin-left z-50"
        style={{ scaleX }}
      />

      <nav className="fixed top-0 left-0 right-0 z-40 bg-slate-950/80 backdrop-blur-md border-b border-white/5">
        <div className="container mx-auto px-4 h-16 flex items-center justify-between">
          <span className="text-xl font-bold bg-gradient-to-r from-blue-400 to-purple-400 bg-clip-text text-transparent">
            Sonderman
          </span>
          <ul className="flex gap-6 text-sm font-medium text-slate-400">
            <li><a href="#" className="hover:text-white transition-colors">Home</a></li>
            <li><a href="#about" className="hover:text-white transition-colors">About</a></li>
            <li><a href="#projects" className="hover:text-white transition-colors">Projects</a></li>
            <li><a href="#contact" className="hover:text-white transition-colors">Contact</a></li>
          </ul>
        </div>
      </nav>

      <main>
        <Hero />
        <About />
        <Projects />
        <Contact />
      </main>
    </div>
  );
}

export default App;
