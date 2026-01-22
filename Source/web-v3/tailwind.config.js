/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        vscode: {
          bg: '#24292e',
          'titlebar-bg': '#1f2428',
          'sidebar-bg': '#24292e',
          'sidebar-hover': '#1f2428', // Activity bar hover
          'explorer-bg': '#1f2428',
          'explorer-hover': '#24292e',
          'tabs-bg': '#1f2428',
          'tab-active': '#24292e',
          'bottom-bg': '#24292e',
          'accent': '#f9826c',
          'text': '#efefef',
          'text-secondary': 'rgba(56, 58, 61, 0.35)',
        }
      }
    },
  },
  plugins: [],
}
