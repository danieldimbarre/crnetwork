import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
	plugins: [vue()],
	base: './',
	build: {
		outDir: '../web-side',
		emptyOutDir: true,
		minify: 'esbuild',
		rollupOptions: {
			output: {
				entryFileNames: 'assets/[name].js',
				chunkFileNames: 'assets/[name].js',
				assetFileNames: 'assets/[name].[ext]'
			}
		}
	}
});
