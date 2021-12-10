<script context="module" lang="ts">
	import type { Load, LoadInput, LoadOutput } from '@sveltejs/kit';
	export const load: Load = async ({ fetch }: LoadInput) => {
		const res = await fetch(`blog.json`);

		if (!res.ok) return;

		const { availablePosts } = await res.json();

		return { props: { availablePosts } } as LoadOutput;
	};
</script>

<script lang="ts">
	import Article from '$lib/wrappers/Article.svelte';
	export let availablePosts: Pick<BlogPostType, 'title' | 'published'>[];
</script>

<Article>
	<h1>Log</h1>
	<ul>
		{#each availablePosts as { title, published }}
			<li>
				<span>{published}</span>
				<a href="blog/{title}">{title}</a>
			</li>
		{:else}
			<li>No logs</li>
		{/each}
	</ul>
</Article>

<style>
	ul {
		width: 100%;
		display: flex;
		flex-direction: column;
		align-items: flex-start;
	}
	li {
		display: flex;
		align-items: center;
		justify-content: space-between;
		gap: 1em;
	}

	li a {
		position: relative;
	}

	li a:not(:visited)::before {
		content: '';
		width: 0.1em;
		height: 0.1em;
		background-color: var(--color-accent);
	}
</style>
