<script lang="ts">
	import Section from '$lib/wrappers/Section.svelte';
	import IntroText from './fragments/IntroText.svelte';
	import Headshot from './fragments/Headshot.svelte';

	export let consultant: ConsultantType;
</script>

{#if consultant}
	<Section hideTitle title={consultant.name}>
		<div>
			<Headshot {consultant} />
			<IntroText {consultant} />
		</div>
	</Section>
{/if}

<style>
	div {
		display: flex;
		align-items: center;
		gap: 2em;
	}

	@media (max-width: 600px) {
		div {
			flex-direction: column;
		}
	}
</style>
