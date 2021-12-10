<script>
	export let title = '';
</script>

<article>
	{#if title.length}
		<h1>{title}</h1>
	{/if}
	<div>
		<slot />
	</div>
</article>

<style>
	article {
		display: flex;
		flex-direction: column;

		padding: 1em;

		width: 100%;
		max-width: var(--main-content-width);

		animation: item-fade-in 0.18s ease-out backwards;
	}
	@keyframes item-fade-in {
		0% {
			opacity: 0;
			transform: translateX(-50px);
		}
	}

	/* @supports (backdrop-filter: blur(0px)) {
		article::after {
			background-color: transparent;
			backdrop-filter: blur(30px) brightness(0.7);
		}
	} */
</style>
