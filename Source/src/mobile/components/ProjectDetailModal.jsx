import React from 'react';
import { motion } from 'framer-motion';
import { X, ExternalLink, Github, Smartphone, Gamepad2 } from 'lucide-react';
import MobileProjectCarousel from './MobileProjectCarousel';
import appStoreIcon from '../../assets/icons/app_store.png';
import googlePlayIcon from '../../assets/icons/google_play.png';

const ProjectDetailModal = ({ project, onClose }) => {
    if (!project) return null;

    return (
        <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 flex items-center justify-center p-0 md:p-4 bg-black/80 backdrop-blur-sm"
            onClick={onClose}
        >
            <motion.div
                initial={{ y: "100%" }}
                animate={{ y: 0 }}
                exit={{ y: "100%" }}
                transition={{ type: "spring", damping: 25, stiffness: 200 }}
                className="bg-background w-full h-full md:h-auto md:max-h-[90vh] md:w-[800px] md:rounded-2xl overflow-hidden flex flex-col relative"
                onClick={(e) => e.stopPropagation()}
            >
                {/* Close Button - Floating */}
                <button
                    onClick={onClose}
                    className="absolute top-4 right-4 z-20 p-2 bg-black/50 text-white rounded-full hover:bg-black/70 transition-colors backdrop-blur-sm"
                >
                    <X size={24} />
                </button>

                {/* Top: Carousel Section */}
                <div className="relative w-full h-[40vh] bg-navy shrink-0">
                    {project.images && project.images.length > 0 ? (
                        project.images.length > 1 ? (
                             <MobileProjectCarousel images={project.images} title={project.title} />
                        ) : (
                            <img
                                src={project.images[0]}
                                alt={project.title}
                                className="w-full h-full object-cover"
                            />
                        )
                    ) : (
                        <div className="w-full h-full flex items-center justify-center text-slate-600">
                            <Gamepad2 size={64} />
                        </div>
                    )}
                </div>

                {/* Bottom: Content Section */}
                <div className="flex-1 overflow-y-auto p-6 md:p-8">
                    <div className="flex items-center justify-between mb-4">
                        <span className="text-sm font-bold px-3 py-1 rounded bg-primary/20 text-primary border border-primary/20">
                            {project.type}
                        </span>
                        <span className="text-slate-400 text-sm">{project.category}</span>
                    </div>

                    <h2 className="text-3xl font-bold text-white mb-4">{project.title}</h2>

                    {/* Platforms */}
                    <div className="flex flex-wrap gap-2 mb-6">
                         {project.platforms && project.platforms.map(p => (
                            <span key={p} className="text-xs text-slate-300 flex items-center gap-1.5 bg-slate-800 px-3 py-1.5 rounded-full border border-slate-700">
                                {p.toLowerCase() === 'android' || p.toLowerCase() === 'ios' ? <Smartphone size={14} /> : <Gamepad2 size={14} />}
                                {p}
                            </span>
                        ))}
                    </div>

                    <p className="text-slate-300 text-base leading-relaxed mb-8 whitespace-pre-wrap">
                        {project.description}
                    </p>

                    {/* Action Buttons */}
                    <div className="flex flex-col sm:flex-row gap-4 mt-auto">
                         {project.links && project.links.map((link, i) => (
                            <a
                                key={i}
                                href={link.url}
                                target="_blank"
                                rel="noopener noreferrer"
                                className={`flex items-center justify-center gap-2 px-6 py-3 rounded-xl font-bold transition-all shadow-lg ${
                                    link.label.toLowerCase().includes('github') 
                                        ? 'bg-slate-800 text-white hover:bg-slate-700 border border-slate-600'
                                        : 'bg-primary text-black hover:bg-yellow-400 shadow-primary/20'
                                }`}
                            >
                                {link.label.toLowerCase().includes('github') ? (
                                    <Github size={20} />
                                ) : link.label.toLowerCase().includes('app store') ? (
                                    <img src={appStoreIcon} alt="App Store" className="w-6 h-6 object-contain" />
                                ) : link.label.toLowerCase().includes('google play') || link.label.toLowerCase().includes('play store') ? (
                                    <img src={googlePlayIcon} alt="Google Play" className="w-6 h-6 object-contain" />
                                ) : (
                                    <ExternalLink size={20} />
                                )}
                                {link.label}
                            </a>
                        ))}
                    </div>
                </div>
            </motion.div>
        </motion.div>
    );
};

export default ProjectDetailModal;
