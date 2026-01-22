import React, { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';

const ProjectCarousel = ({ images, title }) => {
    const [currentIndex, setCurrentIndex] = useState(0);
    const [key, setKey] = useState(0); // Used to reset the interval

    const nextImage = useCallback(() => {
        setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
    }, [images.length]);

    const prevImage = useCallback(() => {
        setCurrentIndex((prevIndex) => (prevIndex - 1 + images.length) % images.length);
    }, [images.length]);

    useEffect(() => {
        if (!images || images.length <= 1) return;

        const interval = setInterval(() => {
            nextImage();
        }, 3000);

        return () => clearInterval(interval);
    }, [images, key, nextImage]);

    const handleDragEnd = (event, info) => {
        const swipeThreshold = 50;
        if (info.offset.x < -swipeThreshold) {
            nextImage();
            setKey(prev => prev + 1); // Reset timer
        } else if (info.offset.x > swipeThreshold) {
            prevImage();
            setKey(prev => prev + 1); // Reset timer
        }
    };

    if (!images || images.length === 0) {
        return (
            <div className="flex items-center justify-center h-full bg-gray-200 text-gray-500 rounded-lg">
                No screenshots available
            </div>
        );
    }

    return (
        <div className="w-full flex flex-col items-center touch-none">
            <div className="relative w-full h-[420px] overflow-hidden rounded-xl shadow-2xl bg-black/40 mb-6">
                <AnimatePresence mode="wait">
                    <motion.img
                        key={currentIndex}
                        src={images[currentIndex]} // Already has full path from personalData
                        alt={`${title} screenshot ${currentIndex + 1}`}
                        initial={{ opacity: 0, x: 20 }}
                        animate={{ opacity: 1, x: 0 }}
                        exit={{ opacity: 0, x: -20 }}
                        transition={{ duration: 0.3, ease: "easeInOut" }}
                        drag="x"
                        dragConstraints={{ left: 0, right: 0 }}
                        onDragEnd={handleDragEnd}
                        className="w-full h-full object-contain cursor-grab active:cursor-grabbing"
                    />
                </AnimatePresence>
            </div>

            {/* Pagination Indicators - Now positioned below the image area */}
            {images.length > 1 && (
                <div className="flex justify-center space-x-2 pointer-events-none mb-2">
                    {images.map((_, idx) => (
                        <div
                            key={idx}
                            className={`w-1.5 h-1.5 rounded-full transition-all duration-300 ${
                                idx === currentIndex ? 'bg-white w-3' : 'bg-white/30'
                            }`}
                        />
                    ))}
                </div>
            )}
        </div>
    );
};

export default ProjectCarousel;
