import React, { useState, useEffect, useCallback } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronLeft, ChevronRight } from 'lucide-react';

const MobileProjectCarousel = ({ images, title }) => {
    const [currentIndex, setCurrentIndex] = useState(0);
    const [key, setKey] = useState(0); // Used to reset the interval

    const nextImage = useCallback(() => {
        setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
        setKey(prev => prev + 1); // Reset timer on manual action
    }, [images.length]);

    const prevImage = useCallback(() => {
        setCurrentIndex((prevIndex) => (prevIndex - 1 + images.length) % images.length);
        setKey(prev => prev + 1); // Reset timer on manual action
    }, [images.length]);

    const goToImage = (index) => {
        setCurrentIndex(index);
        setKey(prev => prev + 1);
    };

    useEffect(() => {
        if (!images || images.length <= 1) return;

        const interval = setInterval(() => {
            setCurrentIndex((prevIndex) => (prevIndex + 1) % images.length);
        }, 3000);

        return () => clearInterval(interval);
    }, [images, key]); // Removed nextImage from dependency to avoid loop with new nextImage logic

    const handleDragEnd = (event, info) => {
        const swipeThreshold = 50;
        if (info.offset.x < -swipeThreshold) {
            nextImage();
        } else if (info.offset.x > swipeThreshold) {
            prevImage();
        }
    };

    if (!images || images.length === 0) return null;

    return (
        <div className="absolute inset-0 w-full h-full touch-pan-y group">
            <AnimatePresence mode="wait">
                <motion.img
                    key={currentIndex}
                    src={images[currentIndex]}
                    alt={`${title} screenshot ${currentIndex + 1}`}
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    transition={{ duration: 0.5 }}
                    drag="x"
                    dragConstraints={{ left: 0, right: 0 }}
                    onDragEnd={handleDragEnd}
                    className="w-full h-full object-cover cursor-grab active:cursor-grabbing"
                    draggable={false}
                />
            </AnimatePresence>

            {/* Navigation Buttons (Only visible if more than 1 image) */}
            {images.length > 1 && (
                <>
                    <button 
                        onClick={(e) => { e.stopPropagation(); prevImage(); }}
                        className="absolute left-2 top-1/2 -translate-y-1/2 p-1.5 rounded-full bg-black/30 text-white hover:bg-black/50 transition-colors opacity-0 group-hover:opacity-100 duration-300 z-10"
                        aria-label="Previous image"
                    >
                        <ChevronLeft size={20} />
                    </button>
                    <button 
                        onClick={(e) => { e.stopPropagation(); nextImage(); }}
                        className="absolute right-2 top-1/2 -translate-y-1/2 p-1.5 rounded-full bg-black/30 text-white hover:bg-black/50 transition-colors opacity-0 group-hover:opacity-100 duration-300 z-10"
                        aria-label="Next image"
                    >
                        <ChevronRight size={20} />
                    </button>
                </>
            )}

            {/* Pagination Indicators */}
            {images.length > 1 && (
                <div className="absolute bottom-2 left-0 right-0 flex justify-center space-x-1.5 z-10">
                    {images.map((_, idx) => (
                        <button
                            key={idx}
                            onClick={(e) => { e.stopPropagation(); goToImage(idx); }}
                            className={`w-2 h-2 rounded-full transition-all duration-300 shadow-sm ${
                                idx === currentIndex ? 'bg-primary w-4' : 'bg-white/50 hover:bg-white/80'
                            }`}
                            aria-label={`Go to image ${idx + 1}`}
                        />
                    ))}
                </div>
            )}
        </div>
    );
};

export default MobileProjectCarousel;
