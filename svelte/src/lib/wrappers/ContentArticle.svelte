<article>
	<slot />
</article>

<style>
	article {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 6em;

		padding: 1em;

		width: 100%;
		max-width: var(--main-content-width);

		animation: enter-left 0.3s ease backwards;
	}

	@supports (backdrop-filter: blur(0px)) {
		article::after {
			background-color: transparent;
			backdrop-filter: blur(30px) brightness(0.7);
		}
	}
</style>
