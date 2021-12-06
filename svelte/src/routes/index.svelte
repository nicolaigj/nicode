<script lang="ts">
	import { consultants } from '$lib/db';
	import ContentArticle from '$lib/wrappers/ContentArticle.svelte';
	import { prefetchRoutes } from '$app/navigation';
	import { onMount } from 'svelte';
	import Section from '$lib/wrappers/Section.svelte';

	onMount(() => {
		prefetchRoutes(consultants.map((c) => c.name));
	});
</script>

<svelte:head>
	<title>nicode</title>
</svelte:head>

<ContentArticle title="Nicode">
	<Section title="Welcome to nicode!">
		<p>We are a tiny consultancy firm focused on people as much as code.</p>
	</Section>
	<Section title="Developers">
		<div>
			{#each consultants as consultant}
				<a sveltekit:prefetch href={consultant.name}>
					<span>{consultant.name}</span>
				</a>
			{/each}
		</div>
	</Section>
</ContentArticle>

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
