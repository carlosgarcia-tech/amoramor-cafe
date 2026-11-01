// @ts-check
import { defineConfig } from 'astro/config';
import vercel from '@astrojs/vercel';
import tailwindcss from '@tailwindcss/vite';

// https://astro.build/config
export default defineConfig({
	// SSR: el middleware de sesión y /admin se ejecutan on-demand en Vercel.
	output: 'server',
	adapter: vercel(),
	vite: {
		plugins: [tailwindcss()],
	},
});
