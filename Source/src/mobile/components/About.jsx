import { motion } from 'framer-motion';
import { personalData } from '../../data/personalData';
import { Code2, Trophy, BookOpen, Briefcase, AppWindow, Gamepad2 } from 'lucide-react';

const About = () => {
    return (
        <section id="about" className="py-20 text-slate-300 relative">
            <div className="container mx-auto px-4">

                {/* Intro & Services */}
                <div className="grid lg:grid-cols-2 gap-16 mb-20">
                    <motion.div
                        initial={{ opacity: 0, x: -20 }}
                        whileInView={{ opacity: 1, x: 0 }}
                        viewport={{ once: true }}
                    >
                        <h2 className="text-3xl font-bold text-white mb-8 border-l-4 border-primary pl-4">About Me</h2>
                        <div className="space-y-4 text-justify text-base leading-relaxed mb-8">
                            {personalData.about.map((paragraph, idx) => (
                                <p key={idx} className="text-slate-400">
                                    {paragraph}
                                </p>
                            ))}
                        </div>
                    </motion.div>

                    {/* Services Cards */}
                    <motion.div
                        initial={{ opacity: 0, x: 20 }}
                        whileInView={{ opacity: 1, x: 0 }}
                        viewport={{ once: true }}
                        className="grid gap-6"
                    >
                        <h2 className="text-3xl font-bold text-white mb-8 border-l-4 border-primary pl-4">What I'm Doing</h2>
                        {personalData.services.map((service, index) => (
                            <div key={index} className="bg-card p-6 rounded-2xl border border-slate-800 hover:border-primary/50 transition-colors flex gap-6 items-start group hover:-translate-y-1 duration-300">
                                <div className="p-4 rounded-xl bg-navy border border-slate-700 text-primary group-hover:bg-primary group-hover:text-black transition-colors shadow-lg">
                                    <service.icon size={32} />
                                </div>
                                <div>
                                    <h3 className="text-xl font-bold text-white mb-2">{service.title}</h3>
                                    <p className="text-slate-400 text-sm leading-relaxed">{service.description}</p>
                                </div>
                            </div>
                        ))}
                    </motion.div>
                </div>

                {/* Skills & Resume */}
                <div className="grid lg:grid-cols-2 gap-16">
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={{ once: true }}
                    >
                        <h3 className="text-2xl font-bold text-white mb-8 flex items-center gap-2">
                            <Code2 className="text-primary" /> Skills
                        </h3>
                        <div className="space-y-6 bg-card p-8 rounded-3xl border border-slate-800">
                            {personalData.skills.map((skill, index) => (
                                <div key={index}>
                                    <div className="flex justify-between mb-2">
                                        <span className="font-bold text-white">{skill.name}</span>
                                        <span className="text-primary font-mono">{skill.percentage}%</span>
                                    </div>
                                    <div className="w-full bg-navy rounded-full h-3 border border-slate-700/50">
                                        <motion.div
                                            className="bg-gradient-to-r from-cyan-500 to-primary h-full rounded-full"
                                            initial={{ width: 0 }}
                                            whileInView={{ width: `${skill.percentage}%` }}
                                            transition={{ duration: 1, delay: 0.2 }}
                                        />
                                    </div>
                                </div>
                            ))}
                        </div>
                    </motion.div>

                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        viewport={{ once: true }}
                        className="relative"
                    >
                        <h3 className="text-2xl font-bold text-white mb-8 flex items-center gap-2">
                            <Trophy className="text-primary" /> Resume
                        </h3>

                        <div className="relative ml-3 border-l-2 border-slate-700 space-y-12 pb-4">
                            {/* Experience */}
                            <div className="ml-8 relative">
                                <span className="absolute -left-[41px] top-0 p-1.5 bg-background border-2 border-primary rounded-full text-primary">
                                    <Briefcase size={16} />
                                </span>
                                <h4 className="text-xl font-bold text-white mb-6">Experience</h4>
                                <div className="space-y-8">
                                    {personalData.resume.experience.map((item, index) => (
                                        <div key={index} className="relative group">
                                            <span className="absolute -left-[43px] top-2 w-3 h-3 bg-primary rounded-full ring-4 ring-background group-hover:scale-125 transition-transform" />
                                            <span className="inline-block px-3 py-1 bg-primary/10 text-primary rounded-full text-xs font-bold mb-2 border border-primary/20">{item.date}</span>
                                            <h5 className="text-lg font-bold text-white">{item.title}</h5>
                                            {item.subtitle && <p className="text-slate-400">{item.subtitle}</p>}
                                            {item.details && (
                                                <ul className="list-disc list-inside mt-2 text-slate-500 text-sm space-y-1 marker:text-primary">
                                                    {item.details.map((detail, i) => (
                                                        <li key={i}>{detail}</li>
                                                    ))}
                                                </ul>
                                            )}
                                        </div>
                                    ))}
                                </div>
                            </div>

                            {/* Education */}
                            <div className="ml-8 relative mt-12">
                                <span className="absolute -left-[41px] top-0 p-1.5 bg-background border-2 border-primary rounded-full text-primary">
                                    <BookOpen size={16} />
                                </span>
                                <h4 className="text-xl font-bold text-white mb-6">Education</h4>
                                <div className="space-y-8">
                                    {personalData.resume.education.map((item, index) => (
                                        <div key={index} className="relative group">
                                            <span className="absolute -left-[43px] top-2 w-3 h-3 bg-primary rounded-full ring-4 ring-background group-hover:scale-125 transition-transform" />
                                            <span className="inline-block px-3 py-1 bg-primary/10 text-primary rounded-full text-xs font-bold mb-2 border border-primary/20">{item.date}</span>
                                            <h5 className="text-lg font-bold text-white">{item.title}</h5>
                                            <p className="text-slate-400">{item.subtitle}</p>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </motion.div>
                </div>
            </div>
        </section>
    );
};

export default About;
