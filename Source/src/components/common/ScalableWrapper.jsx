import React, { useRef, useState, useEffect } from 'react';

/**
 * ScalableWrapper
 * 
 * Bu bileşen, çocuk bileşenini (children) verilen `referenceWidth` ve `referenceHeight` 
 * değerlerine göre render eder. Ardından, kendi kapsayıcısının (parent) genişliğine sığacak 
 * şekilde içeriği `transform: scale()` ile büyütür veya küçültür.
 * 
 * @param {ReactNode} children - Ölçeklenecek içerik
 * @param {number} referenceWidth - İçeriğin tasarlandığı orijinal genişlik
 * @param {number} referenceHeight - İçeriğin tasarlandığı orijinal yükseklik
 * @param {string} aspectRatio - Opsiyonel. Kapsayıcı için en-boy oranı (örn: '16/9'). Belirtilmezse ref boyutlarından hesaplanır.
 */
const ScalableWrapper = ({ children, referenceWidth, referenceHeight, className = '' }) => {
  const containerRef = useRef(null);
  const [scale, setScale] = useState(1);
  const [parentWidth, setParentWidth] = useState(0);

  useEffect(() => {
    const updateSize = () => {
      if (containerRef.current) {
        const currentWidth = containerRef.current.offsetWidth;
        setParentWidth(currentWidth);
        const newScale = currentWidth / referenceWidth;
        setScale(newScale);
      }
    };

    // Initial calc
    updateSize();

    // Resize observer for responsive updates
    const resizeObserver = new ResizeObserver(() => {
        updateSize();
    });

    if (containerRef.current) {
        resizeObserver.observe(containerRef.current);
    }

    window.addEventListener('resize', updateSize);

    return () => {
        window.removeEventListener('resize', updateSize);
        resizeObserver.disconnect();
    };
  }, [referenceWidth]);

  // Kapsayıcı yüksekliğini, ölçeklenmiş içeriğe göre ayarlamalıyız.
  // İçerik referenceHeight boyunda ama scale ile çarpılınca kapladığı yer değişiyor.
  const scaledHeight = referenceHeight * scale;

  return (
    <div 
      ref={containerRef} 
      className={`relative w-full ${className}`}
      style={{ height: scaledHeight }}
    >
      <div
        style={{
          width: referenceWidth,
          height: referenceHeight,
          transform: `scale(${scale})`,
          transformOrigin: 'top left',
          position: 'absolute',
          top: 0,
          left: 0,
        }}
      >
        {children}
      </div>
    </div>
  );
};

export default ScalableWrapper;
