import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { personalData } from '../data/content';
import { ExternalLink, Github, Smartphone, Gamepad2 } from 'lucide-react';

const Projects = () => {
    const [filter, setFilter] = useState('All');

    // Derived categories including 'All'
    const categories = ['All', ...new Set(personalData.projects.map(p => p.category))];

    const filteredProjects = filter === 'All'
        ? personalData.projects
        : personalData.projects.filter(p => p.category === filter);

    return (
        <section id="projects" className="py-20 bg-background relative">
            <div className="container mx-auto px-4">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="text-center mb-12"
                >
                    <h2 className="text-3xl md:text-5xl font-bold mb-6 text-white">Featured Projects</h2>
                    <div className="w-24 h-1.5 bg-primary mx-auto rounded-full mb-10"></div>

                    {/* Filter Bar */}
                    <div className="flex flex-wrap justify-center gap-4 mb-12">
                        {categories.map((cat) => (
                            <button
                                key={cat}
                                onClick={() => setFilter(cat)}
                                className={`px-6 py-2 rounded-full font-medium transition-all duration-300 border-2 ${filter === cat
                                        ? 'bg-primary text-black border-primary shadow-lg shadow-primary/25 scale-105'
                                        : 'bg-transparent text-slate-400 border-slate-700 hover:border-primary hover:text-white'
                                    }`}
                            >
                                {cat}
                            </button>
                        ))}
                    </div>
                </motion.div>

                <motion.div
                    layout
                    className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8"
                >
                    <AnimatePresence>
                        {filteredProjects.map((project, index) => (
                            <motion.div
                                layout
                                key={project.title} // better key than index for filtering
                                initial={{ opacity: 0, scale: 0.9 }}
                                animate={{ opacity: 1, scale: 1 }}
                                exit={{ opacity: 0, scale: 0.9 }}
                                transition={{ duration: 0.3 }}
                                className="group bg-card rounded-2xl overflow-hidden hover:shadow-[0_0_30px_rgba(0,0,0,0.5)] transition-all duration-300 border border-slate-800 hover:border-primary/50 relative top-0 hover:-top-2"
                            >
                                <div className="relative overflow-hidden aspect-video bg-navy">
                                    {project.images && project.images.length > 0 ? (
                                        <img
                                            src={project.images[0]}
                                            alt={project.title}
                                            className="w-full h-full object-cover transform group-hover:scale-110 transition-transform duration-500"
                                        />
                                    ) : (
                                        <div className="w-full h-full flex items-center justify-center text-slate-600">
                                            <Gamepad2 size={48} />
                                        </div>
                                    )}

                                    {/* Overlay Links */}
                                    <div className="absolute inset-0 bg-black/60 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-center justify-center gap-4 backdrop-blur-sm">
                                        {project.links.map((link, i) => (
                                            <a
                                                key={i}
                                                href={link.url}
                                                target="_blank"
                                                rel="noopener noreferrer"
                                                className="p-3 bg-primary text-black rounded-full hover:scale-110 transition-transform shadow-lg"
                                                title={link.label}
                                            >
                                                {link.label.toLowerCase().includes('github') ? <Github size={20} /> : <ExternalLink size={20} />}
                                            </a>
                                        ))}
                                    </div>
                                </div>

                                <div className="p-6">
                                    <div className="flex items-center justify-between mb-3">
                                        <span className="text-xs font-bold px-3 py-1 rounded bg-primary/20 text-primary border border-primary/20">
                                            {project.type}
                                        </span>
                                        <span className="text-slate-500 text-xs">{project.category}</span>
                                    </div>
                                    <h3 className="text-xl font-bold mb-3 text-white group-hover:text-primary transition-colors">{project.title}</h3>
                                    <p className="text-slate-400 text-sm line-clamp-3 mb-4 leading-relaxed">
                                        {project.description}
                                    </p>
                                    <div className="flex flex-wrap gap-2 pt-4 border-t border-slate-800">
                                        {project.platforms.map(p => (
                                            <span key={p} className="text-xs text-slate-500 flex items-center gap-1.5 bg-background px-2 py-1 rounded">
                                                {p.toLowerCase() === 'android' || p.toLowerCase() === 'ios' ? <Smartphone size={12} /> : <Gamepad2 size={12} />}
                                                {p}
                                            </span>
                                        ))}
                                    </div>
                                </div>
                            </motion.div>
                        ))}
                    </AnimatePresence>
                </motion.div>
            </div>
        </section>
    );
};

export default Projects;
