<script lang="ts">
	export let title;
	export let hideTitle = false;

	const id = encodeURIComponent(title.toLowerCase().replace(/\s/g, '-'));
</script>

<section {id}>
	{#if !hideTitle}
		<h2>
			<a href="#{id}">#</a>
			{title}
		</h2>
	{/if}
	<slot />
</section>

<style>
	section {
		scroll-margin: 6rem 0 0 0;
		display: flex;
		flex-direction: column;

		width: 100%;
		max-width: var(--main-content-width);
	}

	section h2 {
		font-size: 2em;
		max-width: max-content;
		margin-bottom: 0.5em;
	}

	@media (min-width: 1100px) {
		section h2 {
			position: relative;
		}
		section h2 a {
			position: absolute;
			left: -1em;
			transition: opacity 0.1s 0.1s ease-in-out;
			opacity: 0;
		}
		section h2:hover a,
		section:focus-within h2 a {
			transition: opacity 0.05s;
			opacity: 1;
		}
	}
</style>
