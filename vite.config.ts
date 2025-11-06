import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0', // listen on all network interfaces (needed for Docker)
    watch: {
      usePolling: true, // enables polling mode (works in Docker)
      interval: 1000,   // check for file changes every second
    },
  },
})
