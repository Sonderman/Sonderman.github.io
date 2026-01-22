import React, { useState, useEffect } from 'react';
import { ZoomIn, ZoomOut, Download, RotateCcw, Loader2 } from 'lucide-react';
import { motion } from 'framer-motion';
import { Document, Page, pdfjs } from 'react-pdf';
import 'react-pdf/dist/Page/AnnotationLayer.css';
import 'react-pdf/dist/Page/TextLayer.css';

// Set worker source for react-pdf
pdfjs.GlobalWorkerOptions.workerSrc = `//unpkg.com/pdfjs-dist@${pdfjs.version}/build/pdf.worker.min.mjs`;

const PDFRenderer = ({ url }) => {
  const [numPages, setNumPages] = useState(null);
  const [scale, setScale] = useState(1.2);
  const [loading, setLoading] = useState(true);

  const onDocumentLoadSuccess = ({ numPages }) => {
    setNumPages(numPages);
    setLoading(false);
  };

  const handleZoomIn = () => setScale(prev => Math.min(prev + 0.1, 3.0));
  const handleZoomOut = () => setScale(prev => Math.max(prev - 0.1, 0.5));
  const handleResetZoom = () => setScale(1.2);

  return (
    <div className="w-full h-full bg-[#1e1e1e] flex flex-col relative overflow-hidden group">
      {/* PDF Toolbar - Positioned bottom-right */}
      <div className="absolute bottom-8 right-8 z-20 flex items-center bg-[#252526] border border-[#3e3e3e] rounded-full px-4 py-2 shadow-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-300">
        <div className="flex items-center gap-1 border-r border-[#3e3e3e] pr-3 mr-3 text-gray-400">
          <button 
            onClick={handleZoomOut}
            className="p-1 hover:bg-[#37373d] rounded transition-colors hover:text-white"
            title="Zoom Out"
          >
            <ZoomOut size={18} />
          </button>
          
          <span className="text-xs font-mono min-w-[45px] text-center select-none">
            {Math.round(scale * 100)}%
          </span>
          
          <button 
            onClick={handleZoomIn}
            className="p-1 hover:bg-[#37373d] rounded transition-colors hover:text-white"
            title="Zoom In"
          >
            <ZoomIn size={18} />
          </button>

          <button 
            onClick={handleResetZoom}
            className="p-1 hover:bg-[#37373d] rounded transition-colors hover:text-white ml-1"
            title="Reset Zoom"
          >
            <RotateCcw size={16} />
          </button>
        </div>

        <a 
          href={url} 
          download
          className="p-1 hover:bg-[#37373d] rounded transition-colors text-gray-400 hover:text-white"
          title="Download PDF"
        >
          <Download size={18} />
        </a>
      </div>

      {/* PDF Viewport */}
      <div className="flex-1 overflow-auto custom-scrollbar flex items-start justify-center p-8">
        <Document
          file={url}
          onLoadSuccess={onDocumentLoadSuccess}
          loading={
            <div className="flex flex-col items-center justify-center h-[500px] text-gray-500 gap-4">
              <Loader2 className="animate-spin" size={32} />
              <p>Loading PDF...</p>
            </div>
          }
          className="flex flex-col items-center gap-8"
        >
          {Array.from(new Array(numPages), (el, index) => (
            <motion.div
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              key={`page_${index + 1}`}
              className="shadow-2xl"
            >
              <Page 
                pageNumber={index + 1} 
                scale={scale}
                className="bg-white"
                loading={null}
              />
            </motion.div>
          ))}
        </Document>
      </div>
    </div>
  );
};

export default PDFRenderer;
