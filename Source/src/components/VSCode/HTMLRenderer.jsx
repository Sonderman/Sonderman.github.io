import React, { useRef, useEffect } from 'react';

const HTMLRenderer = ({ content }) => {
  const iframeRef = useRef(null);

  useEffect(() => {
    if (iframeRef.current) {
        // When content changes, we can just let the srcDoc handle it, 
        // but explicit document writing is sometimes more reliable for dynamic scripts if needed.
        // For now, srcDoc is sufficient and cleaner.
    }
  }, [content]);

  return (
    <div className="w-full h-full bg-white overflow-hidden">
      <iframe
        ref={iframeRef}
        title="HTML Preview"
        srcDoc={content}
        className="w-full h-full border-none"
        sandbox="allow-scripts allow-top-navigation-by-user-activation allow-popups allow-forms allow-same-origin"
      />
    </div>
  );
};

export default HTMLRenderer;
