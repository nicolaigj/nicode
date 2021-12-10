<script lang="ts">
	import Projects from './projects/Projects.svelte';
	import ConsultantHeroSection from './hero/ConsultantHeroSection.svelte';
	import Section from '$lib/wrappers/Section.svelte';
	import Article from '$lib/wrappers/Article.svelte';

	export let consultant: ConsultantType;

	let { availability, focus } = consultant;
</script>

<Article>
	<ConsultantHeroSection {consultant} />

	<Section title="About Me">
		<p>
			{focus}
		</p>
		<p>
			{availability} <a href="mailto:{consultant.contact.email}">Contact me!</a>
		</p>
	</Section>

	<Section title="Experience and projects">
		<Projects {consultant} />
	</Section>
</Article>

<style>
	p:nth-of-type(2) {
		margin-top: 1em;
		font-style: italic;
	}
</style>
