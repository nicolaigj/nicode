<script lang="ts">
	import '@fontsource/archivo';
	import '../default.css';
	import '../config.css';

	import Navigation from '$lib/nav/Navigation.svelte';
</script>

<header>
	<Navigation />
</header>

<main>
	<slot />
</main>

<footer>
	<p>Created with love, <time datetime="2021-02">Dec 2021</time></p>
</footer>

<style>
	:global(body) {
		font-family: Archivo, sans-serif;
	}
	header,
	main,
	footer {
		display: flex;
		flex-direction: column;
		align-items: center;

		max-width: var(--max-width);
		margin: 0 auto;
		width: 100%;
	}
	header,
	footer {
		z-index: 11;
	}
	main {
		flex: auto;
		position: relative;
		z-index: 10;
		margin: 3em auto;
	}
	footer {
		margin-top: 1em;
		padding: 0.5em 1em;

		color: var(--color-content);
	}

	footer > p {
		max-width: var(--main-content-width);
		width: 100%;
		font-size: 0.65em;
		opacity: 0.5;
	}
</style>
