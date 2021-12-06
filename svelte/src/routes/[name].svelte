<script context="module" lang="ts">
	import { consultants } from '$lib/db';

	export const load = async ({ page }) => {
		// look up the consultant, ignore case
		const consultant = consultants.find(
			(c) => c.name.toLowerCase() === page.params.name.toLowerCase()
		);

		return { props: { consultant }, status: consultant ? 200 : 404 };
	};
</script>

<script lang="ts">
	import ConsultantArticle from '$lib/consultant/ConsultantArticle.svelte';
	export let consultant;
</script>

<svelte:head>
	<title>nicode - {consultant.name}</title>
</svelte:head>

<ConsultantArticle {consultant} />
