import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
	server: { 
        host: '0.0.0.0',      // Escuchar conexiones externas
        port: 5173,           // Puerto fijo
        hmr: {
            host: 'localhost' // Para que Windows sepa dónde buscar los cambios
        }
    },
    plugins: [
        laravel({
            input: ['resources/css/app.css', 'resources/js/app.js'],
            refresh: true,
        }),
    ],
});
