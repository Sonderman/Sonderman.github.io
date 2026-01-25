import React, { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { Award, ExternalLink, X, Calendar, Building2 } from 'lucide-react';

const CertificateCard = ({ cert, index, onPreview }) => {
    return (
        <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.4, delay: index * 0.1 }}
            className="group bg-[#1e293b]/40 backdrop-blur-md border border-white/5 rounded-xl p-5 hover:border-vscode-accent/50 transition-all duration-300 shadow-lg hover:shadow-vscode-accent/10"
        >
            <div className="flex flex-col h-full">
                <div className="flex items-start justify-between mb-4">
                    <div className="p-2 bg-vscode-accent/10 rounded-lg group-hover:bg-vscode-accent/20 transition-colors">
                        <Award className="w-6 h-6 text-vscode-accent" />
                    </div>
                    <div className="flex gap-2">
                        {cert.verificationUrl && (
                            <a
                                href={cert.verificationUrl}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="p-2 hover:bg-vscode-accent/10 rounded-full transition-colors opacity-0 group-hover:opacity-100 text-vscode-accent"
                                title="Verify Certificate"
                                onClick={(e) => e.stopPropagation()}
                            >
                                <ExternalLink className="w-4 h-4" />
                            </a>
                        )}
                        <button
                            onClick={() => onPreview(cert)}
                            className="p-2 hover:bg-white/5 rounded-full transition-colors opacity-0 group-hover:opacity-100"
                            title="Preview Certificate"
                        >
                            <ExternalLink className="w-4 h-4 text-gray-400 hover:text-white" />
                        </button>
                    </div>
                </div>

                <h3
                    className="text-white font-semibold text-lg mb-2 group-hover:text-vscode-accent transition-colors cursor-pointer"
                    onClick={() => onPreview(cert)}
                >
                    {cert.title}
                </h3>

                <div className="space-y-2 mt-auto">
                    <div className="flex items-center gap-2 text-sm text-gray-400">
                        <Building2 className="w-4 h-4" />
                        <span>{cert.issuer}</span>
                    </div>
                    <div className="flex items-center gap-2 text-sm text-gray-400">
                        <Calendar className="w-4 h-4" />
                        <span>{cert.date}</span>
                    </div>
                </div>
            </div>
        </motion.div>
    );
};

const CertificatesPreview = ({ certificates }) => {
    const [selectedCert, setSelectedCert] = useState(null);

    return (
        <div className="w-full h-full p-6 md:p-10 bg-[#1e1e1e] overflow-y-auto custom-scrollbar">
            <div className="max-w-6xl mx-auto">
                <motion.div
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    className="flex items-center gap-3 mb-10"
                >
                    <Award className="text-vscode-accent w-8 h-8" />
                    <h1 className="text-3xl font-bold text-white tracking-tight">
                        Certifications
                    </h1>
                </motion.div>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {certificates.map((cert, index) => (
                        <CertificateCard
                            key={index}
                            cert={cert}
                            index={index}
                            onPreview={setSelectedCert}
                        />
                    ))}
                </div>

                {/* Modal-style Preview Overlay */}
                <AnimatePresence>
                    {selectedCert && (
                        <motion.div
                            initial={{ opacity: 0 }}
                            animate={{ opacity: 1 }}
                            exit={{ opacity: 0 }}
                            className="fixed inset-0 z-50 flex items-center justify-center p-4 md:p-10 bg-black/80 backdrop-blur-sm"
                            onClick={() => setSelectedCert(null)}
                        >
                            <motion.div
                                initial={{ scale: 0.9, opacity: 0 }}
                                animate={{ scale: 1, opacity: 1 }}
                                exit={{ scale: 0.9, opacity: 0 }}
                                className="relative max-w-5xl w-full bg-[#1e1e1e] rounded-2xl overflow-hidden shadow-2xl border border-white/10"
                                onClick={(e) => e.stopPropagation()}
                            >
                                <div className="absolute top-4 right-4 z-10">
                                    <motion.button
                                        whileHover={{
                                            scale: 1.1,
                                            rotate: 90,
                                            backgroundColor: "rgba(239, 68, 68, 0.8)" // Red on hover
                                        }}
                                        whileTap={{ scale: 0.9 }}
                                        animate={{
                                            boxShadow: [
                                                "0 0 0 0px rgba(255, 255, 255, 0)",
                                                "0 0 0 10px rgba(255, 255, 255, 0.1)",
                                                "0 0 0 0px rgba(255, 255, 255, 0)"
                                            ]
                                        }}
                                        transition={{
                                            boxShadow: {
                                                duration: 2,
                                                repeat: Infinity,
                                                ease: "easeInOut"
                                            },
                                            rotate: { duration: 0.3 }
                                        }}
                                        onClick={() => setSelectedCert(null)}
                                        className="p-2 bg-black/50 rounded-full text-white transition-colors flex items-center justify-center border border-white/10"
                                    >
                                        <X className="w-6 h-6" />
                                    </motion.button>
                                </div>

                                <div className="flex flex-col md:flex-row h-full max-h-[90vh]">
                                    <div className="w-full md:w-2/3 bg-black flex items-center justify-center p-4">
                                        <img
                                            src={selectedCert.image}
                                            alt={selectedCert.title}
                                            className="max-w-full max-h-full object-contain rounded-sm shadow-xl"
                                        />
                                    </div>
                                    <div className="w-full md:w-1/3 p-8 flex flex-col justify-center">
                                        <div className="p-3 bg-vscode-accent/10 w-fit rounded-xl mb-6">
                                            <Award className="w-8 h-8 text-vscode-accent" />
                                        </div>
                                        <h2 className="text-2xl font-bold text-white mb-4 leading-tight">
                                            {selectedCert.title}
                                        </h2>
                                        <div className="space-y-4 text-gray-400 mb-8">
                                            <div className="flex items-center gap-3">
                                                <Building2 className="w-5 h-5 text-gray-500" />
                                                <span className="text-lg">{selectedCert.issuer}</span>
                                            </div>
                                            <div className="flex items-center gap-3">
                                                <Calendar className="w-5 h-5 text-gray-500" />
                                                <span className="text-lg">{selectedCert.date}</span>
                                            </div>
                                        </div>

                                        {selectedCert.verificationUrl && (
                                            <motion.a
                                                href={selectedCert.verificationUrl}
                                                target="_blank"
                                                rel="noopener noreferrer"
                                                whileHover={{ scale: 1.02 }}
                                                whileTap={{ scale: 0.98 }}
                                                className="flex items-center justify-center gap-2 w-full py-4 bg-vscode-accent hover:bg-vscode-accent/90 text-white rounded-xl font-semibold transition-colors shadow-lg shadow-vscode-accent/20"
                                            >
                                                <ExternalLink className="w-5 h-5" />
                                                Verify Credential
                                            </motion.a>
                                        )}

                                        <div className="mt-10 pt-8 border-t border-white/5">
                                            <p className="text-sm text-gray-500 italic">
                                                Verified credential through official {selectedCert.issuer} platform.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </motion.div>
                        </motion.div>
                    )}
                </AnimatePresence>
            </div>
        </div>
    );
};

export default CertificatesPreview;
