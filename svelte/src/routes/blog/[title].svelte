<script context="module" lang="ts">
	import type { Load, LoadInput, LoadOutput } from '@sveltejs/kit';
	export const load: Load = async ({ page, fetch }: LoadInput) => {
		const res = await fetch(`/blog/${page.params.title}.json`);

		if (!res.ok) return;

		const { post } = await res.json();

		return { props: { post } } as LoadOutput;
	};
</script>

<script lang="ts">
	import Article from '$lib/wrappers/Article.svelte';
	import Section from '$lib/wrappers/Section.svelte';
	export let post: BlogPostType;
</script>

<Article title={post.title}>
	<Section>
		{post.published}
		<p>
			{post.preamble}
		</p>
		<p>
			{post.content}
		</p>
	</Section>
</Article>
