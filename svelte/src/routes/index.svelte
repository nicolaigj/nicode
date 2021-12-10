<script context="module" lang="ts">
	export const load = async ({ fetch }) => {
		const res = await fetch(`/\.json`);
		console.log('->', res.url);

		if (!res.ok) return;

		const { consultants } = await res.json();

		return { props: { consultants } };
	};
</script>

<script lang="ts">
	import Article from '$lib/wrappers/Article.svelte';
	import Section from '$lib/wrappers/Section.svelte';
	export let consultants;
</script>

<svelte:head>
	<title>nicode</title>
</svelte:head>

<Article>
	<Section title="Welcome to nicode!">
		<p>We are a tiny consultancy firm focused on people as much as code.</p>
		<div>
			{#each consultants as consultant}
				<a sveltekit:prefetch href={consultant.name}>
					<span>{consultant.name}</span>
				</a>
			{/each}
		</div>
	</Section>
</Article>

<style>
	a {
		border-radius: 6px;
		text-decoration: none;
		padding: 0.5em 1em;
		border: 2px solid var(--color-interactive);
	}
	div {
		display: flex;
		gap: 1em;
	}
</style>
