import { useCallback } from "react";
import Particles from "@tsparticles/react";
import { loadSlim } from "@tsparticles/slim";
import { motion, useScroll, useTransform } from 'framer-motion';
import { personalData } from '../../data/personalData';
import { TypeAnimation } from 'react-type-animation';
import { Github, Linkedin, Mail } from 'lucide-react';

import profileImage from '../../assets/profileImage.png';
import flutterIcon from '../../assets/icons/flutter.png';
import unityIcon from '../../assets/icons/unity.png';

const Hero = () => {
    const { scrollY } = useScroll();
    const opacity = useTransform(scrollY, [0, 200], [1, 0]);

    const particlesInit = useCallback(async (engine) => {
        await loadSlim(engine);
    }, []);
    const particlesOptions = {
        background: { color: { value: "transparent" } },
        fpsLimit: 120,
        interactivity: {
            events: {
                onHover: { enable: true, mode: "grab" },
                resize: true,
            },
            modes: {
                grab: { distance: 140, links: { opacity: 1 } },
            },
        },
        particles: {
            color: { value: "#ffffff" },
            links: {
                color: "#ffffff",
                distance: 150,
                enable: true,
                opacity: 0.2,
                width: 1,
            },
            move: {
                direction: "none",
                enable: true,
                outModes: { default: "bounce" },
                random: false,
                speed: 1,
                straight: false,
            },
            number: { density: { enable: true, area: 800 }, value: 80 },
            opacity: { value: 0.3 },
            shape: { type: "circle" },
            size: { value: { min: 1, max: 3 } },
        },
        detectRetina: true,
    };

    return (
        <section className="min-h-screen flex items-center justify-center relative overflow-hidden pt-16">
            <Particles
                id="tsparticles"
                init={particlesInit}
                options={particlesOptions}
                className="absolute inset-0 -z-10"
            />

            <div className="container mx-auto px-4 grid md:grid-cols-2 gap-12 items-center relative z-10">
                <motion.div
                    initial={{ opacity: 0, x: -50 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 0.8 }}
                    className="order-2 md:order-1 text-center md:text-left"
                >
                    <h2 className="text-xl md:text-2xl font-medium text-primary mb-2">Hello, I'm</h2>
                    <h1 className="text-5xl md:text-7xl font-bold mb-4 text-white tracking-tight">
                        {personalData.name}
                    </h1>
                    <div className="text-2xl md:text-3xl font-light text-slate-300 mb-8 h-[60px] flex items-center justify-center md:justify-start gap-2">
                        <span className="text-slate-400">I am a</span>
                        <TypeAnimation
                            sequence={[
                                'Software Developer', 2000,
                                'Flutter Developer', 2000,
                                'Game Developer', 2000,
                                'Mobile App Developer', 2000,
                            ]}
                            wrapper="span"
                            speed={50}
                            className="font-semibold text-primary"
                            repeat={Infinity}
                        />
                    </div>

                    <p className="text-slate-400 text-lg mb-8 max-w-lg leading-relaxed mx-auto md:mx-0">
                        Passionate about building high-performance applications and immersive gaming experiences.
                    </p>

                    <div className="flex flex-col sm:flex-row gap-4 justify-center md:justify-start w-full">
                        <a
                            href="#projects"
                            className="w-full sm:w-auto px-8 py-3 bg-primary text-black rounded-full font-bold hover:bg-yellow-400 transition-all shadow-[0_0_20px_rgba(255,204,0,0.3)] hover:shadow-[0_0_30px_rgba(255,204,0,0.5)] hover:-translate-y-1 text-center"
                        >
                            View Projects
                        </a>
                        <a
                            href="#contact"
                            className="w-full sm:w-auto px-8 py-3 bg-transparent text-white border-2 border-primary rounded-full font-bold hover:bg-primary/10 transition-all hover:-translate-y-1 text-center"
                        >
                            Get in Touch
                        </a>
                    </div>

                    <div className="flex gap-8 mt-12 justify-center md:justify-start">
                        {personalData.contact.socials.map((social) => (
                            <a
                                key={social.name}
                                href={social.url}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="text-slate-300 hover:text-primary p-3 rounded-full bg-slate-800/50 hover:bg-slate-700 transition-all duration-300 transform hover:scale-110 border border-slate-700 hover:border-primary"
                                aria-label={social.name}
                            >
                                <social.icon size={28} />
                            </a>
                        ))}
                    </div>
                </motion.div>

                <motion.div
                    initial={{ opacity: 0, scale: 0.8 }}
                    animate={{ opacity: 1, scale: 1 }}
                    transition={{ duration: 0.8 }}
                    className="order-1 md:order-2 flex justify-center relative"
                >
                    <div className="relative w-72 h-72 md:w-96 md:h-96">
                        {/* Profile Image Container */}
                        <div className="absolute inset-0 rounded-full border-4 border-primary shadow-[0_0_50px_rgba(255,204,0,0.2)] overflow-hidden bg-navy z-20">
                             <img 
                                src={profileImage} 
                                alt="Profile" 
                                className="w-full h-full object-cover"
                            />
                        </div>

                        {/* Floating Icons mimicking the original site */}
                        <motion.div
                            animate={{ y: [0, -20, 0] }}
                            transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
                            className="absolute -top-4 -right-4 w-20 h-20 bg-card border-2 border-primary rounded-full flex items-center justify-center z-30 shadow-lg overflow-hidden"
                        >
                             <img src={flutterIcon} alt="Flutter" className="w-12 h-12 object-contain" />
                        </motion.div>

                        <motion.div
                            animate={{ y: [0, 20, 0] }}
                            transition={{ duration: 5, repeat: Infinity, ease: "easeInOut", delay: 1 }}
                            className="absolute -bottom-4 -left-4 w-20 h-20 bg-card border-2 border-primary rounded-full flex items-center justify-center z-30 shadow-lg overflow-hidden"
                        >
                            <img src={unityIcon} alt="Unity" className="w-12 h-12 object-contain" />
                        </motion.div>
                    </div>
                </motion.div>
            </div>

            {/* Scroll Indicator */}
            <motion.div
                style={{ opacity }}
                animate={{ y: [0, 10, 0] }}
                transition={{ duration: 1.5, repeat: Infinity }}
                className="fixed bottom-10 right-8 text-slate-500 z-50 pointer-events-none"
            >
                <div className="w-6 h-10 border-2 border-slate-500 rounded-full flex justify-center p-1 bg-slate-900/50 backdrop-blur-sm">
                    <div className="w-1 h-2 bg-primary rounded-full" />
                </div>
            </motion.div>
        </section>
    );
};
export default Hero;
