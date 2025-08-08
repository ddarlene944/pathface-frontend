import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// Change this if your backend is on a different port or domain
const backendUrl = 'http://127.0.0.1:8000'

export default defineConfig({
  plugins: [vue()],
  server: {
    port: 5173, // You can change this if needed
    proxy: {
      '/api': {
        target: backendUrl,
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ''),
      },
    },
  },
  build: {
    outDir: '../backend/static', // Where Vite builds production files
    emptyOutDir: true,
  },
  base: './',
})
