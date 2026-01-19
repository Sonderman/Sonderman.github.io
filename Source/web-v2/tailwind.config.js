/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./index.html",
        "./src/**/*.{js,ts,jsx,tsx}",
    ],
    theme: {
        extend: {
            colors: {
                background: "#050a18", // Deep Navy
                primary: "#ffcc00", // Bright Yellow
                secondary: "#94a3b8", // Slate-400 equivalent for text
                card: "#111a28", // Dark Blue-Grey
                navy: "#050a18",
                accent: "#ffcc00",
            },
            fontFamily: {
                sans: ['Inter', 'sans-serif'],
            },
        },
    },
    plugins: [],
}
