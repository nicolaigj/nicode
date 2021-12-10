<script>
	const route = [{ desc: 'n' }];
</script>

<nav>
	<div>
		<a href="/">nicode</a>
	</div>
	<div>
		<a href="/blog">blog</a>
	</div>
</nav>

<style>
	nav {
		width: 100%;
		padding: 0 1em;

		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 2em;
	}
	div {
		display: flex;
		align-items: center;
		gap: 2em;
	}
	a[href='/'] {
		font-size: 2em;
		font-weight: bold;
	}
</style>
