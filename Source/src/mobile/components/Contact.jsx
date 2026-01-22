import { motion } from 'framer-motion';
import { personalData } from '../../data/personalData';
import { Mail, MapPin } from 'lucide-react';

const Contact = () => {
    return (
        <section id="contact" className="py-20 relative overflow-hidden bg-background">
            {/* Decorative background */}
            <div className="absolute inset-0 bg-primary/5 -z-10 skew-y-3 transform origin-left"></div>

            <div className="container mx-auto px-4 text-center">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    className="max-w-3xl mx-auto"
                >
                    <h2 className="text-4xl md:text-5xl font-bold mb-4 text-white">Let's Work Together</h2>
                    <div className="w-24 h-1.5 bg-primary mx-auto rounded-full mb-8"></div>
                    <p className="text-slate-400 mb-12 text-base md:text-lg leading-relaxed px-4">
                        I'm currently available for freelance projects and full-time opportunities.
                        If you have a project in mind or just want to say hi, feel free to reach out!
                    </p>

                    <div className="grid md:grid-cols-2 gap-6 max-w-2xl mx-auto">
                        <a
                            href={`mailto:${personalData.contact.email}`}
                            className="flex flex-col items-center gap-4 p-6 bg-card rounded-2xl border border-slate-800 hover:border-primary/50 transition-all duration-300 group shadow-lg hover:shadow-primary/10 hover:-translate-y-1"
                        >
                            <div className="p-4 bg-navy rounded-full text-primary group-hover:bg-primary group-hover:text-black transition-all duration-300 ring-2 ring-primary/30 group-hover:ring-primary">
                                <Mail size={32} />
                            </div>
                            <div className="text-center">
                                <h3 className="text-sm text-slate-500 mb-2 uppercase tracking-wider">Email Me</h3>
                                <p className="text-base md:text-lg font-semibold text-white group-hover:text-primary transition-colors break-all">
                                    {personalData.contact.email}
                                </p>
                            </div>
                        </a>

                        <div className="flex flex-col items-center gap-4 p-6 bg-card rounded-2xl border border-slate-800 shadow-lg">
                            <div className="p-4 bg-navy rounded-full text-primary ring-2 ring-primary/30">
                                <MapPin size={32} />
                            </div>
                            <div className="text-center">
                                <h3 className="text-sm text-slate-500 mb-2 uppercase tracking-wider">Location</h3>
                                <p className="text-base md:text-lg font-semibold text-white">
                                    {personalData.contact.location}
                                </p>
                            </div>
                        </div>
                    </div>

                    <footer className="mt-16 pt-8 border-t border-slate-800 text-slate-500 text-sm">
                        <p>© {new Date().getFullYear()} {personalData.name}. All rights reserved.</p>
                    </footer>
                </motion.div>
            </div>
        </section>
    );
};

export default Contact;
