import { useCallback } from "react";
import Particles from "@tsparticles/react";
import { loadSlim } from "@tsparticles/slim";
import { motion } from 'framer-motion';
import { personalData } from '../data/content';
import { TypeAnimation } from 'react-type-animation';
import { Github, Linkedin, Mail } from 'lucide-react';

const Hero = () => {
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

                    <div className="flex flex-wrap gap-4 justify-center md:justify-start">
                        <a
                            href="#projects"
                            className="px-8 py-3 bg-primary text-black rounded-full font-bold hover:bg-yellow-400 transition-all shadow-[0_0_20px_rgba(255,204,0,0.3)] hover:shadow-[0_0_30px_rgba(255,204,0,0.5)] hover:-translate-y-1"
                        >
                            View Projects
                        </a>
                        <a
                            href="#contact"
                            className="px-8 py-3 bg-transparent text-white border-2 border-primary rounded-full font-bold hover:bg-primary/10 transition-all hover:-translate-y-1"
                        >
                            Get in Touch
                        </a>
                    </div>

                    <div className="flex gap-6 mt-12 justify-center md:justify-start">
                        {personalData.contact.socials.map((social) => (
                            <a
                                key={social.name}
                                href={social.url}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="text-slate-400 hover:text-white hover:bg-primary hover:text-black p-2 rounded-full transition-all duration-300 transform hover:scale-110"
                                aria-label={social.name}
                            >
                                <social.icon size={24} />
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
                            {/* Create a generic avatar since we don't have the file */}
                            <div className="w-full h-full bg-slate-800 flex items-center justify-center">
                                <span className="text-8xl">👨‍💻</span>
                            </div>
                        </div>

                        {/* Floating Icons mimicking the original site */}
                        <motion.div
                            animate={{ y: [0, -20, 0] }}
                            transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
                            className="absolute -top-4 -right-4 w-20 h-20 bg-card border-2 border-primary rounded-full flex items-center justify-center z-30 shadow-lg"
                        >
                            <span className="font-bold text-xs text-center text-white">Flutter</span>
                        </motion.div>

                        <motion.div
                            animate={{ y: [0, 20, 0] }}
                            transition={{ duration: 5, repeat: Infinity, ease: "easeInOut", delay: 1 }}
                            className="absolute -bottom-4 -left-4 w-20 h-20 bg-card border-2 border-primary rounded-full flex items-center justify-center z-30 shadow-lg"
                        >
                            <span className="font-bold text-xs text-center text-white">Unity</span>
                        </motion.div>
                    </div>
                </motion.div>
            </div>

            {/* Scroll Indicator */}
            <motion.div
                animate={{ y: [0, 10, 0] }}
                transition={{ duration: 1.5, repeat: Infinity }}
                className="absolute bottom-8 left-1/2 -translate-x-1/2 text-slate-500"
            >
                <div className="w-6 h-10 border-2 border-slate-500 rounded-full flex justify-center p-1">
                    <div className="w-1 h-2 bg-primary rounded-full" />
                </div>
            </motion.div>
        </section>
    );
};
export default Hero;
