// @ts-check
import { defineConfig } from 'astro/config';
import node from '@astrojs/node';
import vercel from '@astrojs/vercel';
import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
// DOCKER=1 construye para contenedor (@astrojs/node standalone); el resto, Vercel.
export default defineConfig({
	// SSR: el middleware de sesión y /admin se ejecutan on-demand en Vercel.
	output: 'server',
	adapter: process.env.DOCKER === '1' ? node({ mode: 'standalone' }) : vercel(),
	vite: {
		plugins: [tailwindcss()],
	},
});
