import { motion } from 'framer-motion';
import { personalData } from '../data/content';
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
                    className="max-w-2xl mx-auto"
                >
                    <h2 className="text-3xl md:text-4xl font-bold mb-6 text-white">Let's Work Together</h2>
                    <p className="text-slate-400 mb-12 text-lg">
                        I'm currently available for freelance projects and full-time opportunities.
                        If you have a project in mind or just want to say hi, feel free to reach out!
                    </p>

                    <div className="grid md:grid-cols-2 gap-6">
                        <a
                            href={`mailto:${personalData.contact.email}`}
                            className="flex items-center justify-center gap-4 p-8 bg-card rounded-2xl border border-slate-700 hover:border-primary transition-colors group shadow-lg"
                        >
                            <div className="p-4 bg-navy rounded-full text-slate-400 group-hover:bg-primary group-hover:text-black transition-colors ring-1 ring-slate-700 group-hover:ring-primary">
                                <Mail size={32} />
                            </div>
                            <div className="text-left">
                                <h3 className="text-sm text-slate-400 mb-1">Email Me</h3>
                                <p className="text-lg font-medium text-white break-all group-hover:text-primary transition-colors">{personalData.contact.email}</p>
                            </div>
                        </a>

                        <div className="flex items-center justify-center gap-4 p-8 bg-card rounded-2xl border border-slate-700 shadow-lg">
                            <div className="p-4 bg-navy rounded-full text-primary ring-1 ring-primary/30">
                                <MapPin size={32} />
                            </div>
                            <div className="text-left">
                                <h3 className="text-sm text-slate-400 mb-1">Location</h3>
                                <p className="text-lg font-medium text-white">{personalData.contact.location}</p>
                            </div>
                        </div>
                    </div>

                    <footer className="mt-20 pt-8 border-t border-slate-800 text-slate-500 text-sm">
                        <p>© {new Date().getFullYear()} {personalData.name}. All rights reserved.</p>
                    </footer>
                </motion.div>
            </div>
        </section>
    );
};

export default Contact;
