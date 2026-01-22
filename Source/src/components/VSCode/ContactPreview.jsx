import React from 'react';
import { personalData } from '../../data/personalData';

const ContactPreview = () => {
    return (
        <div className="flex flex-col items-center justify-center w-full h-full bg-[#1e1e1e] text-[#d4d4d4] font-mono p-4">
            <h1 className="text-3xl mb-4 font-bold text-[#ff9e64]">Contact Me</h1>
            <p className="mb-8 text-center max-w-lg text-[#a9b7c6]">
                Feel free to reach out to me through any of the social platforms below. I'm always open to new opportunities and connections.
            </p>

            <div className="bg-[#1e1e1e] p-8 border-l-4 border-[#ff9e64] shadow-lg rounded max-w-md w-full relative">
                <div className="absolute top-0 right-0 p-2 text-xs text-gray-500">contact.css</div>
                <div className="flex">
                    <div className="text-gray-600 select-none text-right pr-4 border-r border-gray-700 mr-4 font-mono text-sm leading-7">
                        1<br/>2<br/>3<br/>4<br/>5<br/>6
                    </div>
                    <div className="text-sm leading-7 font-mono w-full">
                        <span className="text-[#ff9e64]">.socials</span> <span className="text-[#d4d4d4]">{`{`}</span><br/>
                        &nbsp;&nbsp;<span className="text-[#9cdcfe]">website</span>: <a href="https://github.com/Sonderman" target="_blank" rel="noopener noreferrer" className="text-[#ce9178] hover:underline hover:text-[#ff9e64] transition-colors">'sonderman.github.io'</a><span className="text-[#d4d4d4] ;">;</span><br/>
                        &nbsp;&nbsp;<span className="text-[#9cdcfe]">email</span>: <a href={`mailto:${personalData.contact.email}`} className="text-[#ce9178] hover:underline hover:text-[#ff9e64] transition-colors">'{personalData.contact.email}'</a><span className="text-[#d4d4d4] ;">;</span><br/>
                        &nbsp;&nbsp;<span className="text-[#9cdcfe]">github</span>: <a href="https://github.com/sonderman" target="_blank" rel="noopener noreferrer" className="text-[#ce9178] hover:underline hover:text-[#ff9e64] transition-colors">'github.com/sonderman'</a><span className="text-[#d4d4d4] ;">;</span><br/>
                        &nbsp;&nbsp;<span className="text-[#9cdcfe]">linkedin</span>: <a href={personalData.contact.socials.find(s => s.name === 'LinkedIn')?.url} target="_blank" rel="noopener noreferrer" className="text-[#ce9178] hover:underline hover:text-[#ff9e64] transition-colors">'{personalData.name}'</a><span className="text-[#d4d4d4] ;">;</span><br/>
                        <span className="text-[#d4d4d4]">{`}`}</span>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ContactPreview;
