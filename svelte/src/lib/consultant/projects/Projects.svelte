<script lang="ts">
	import Main from './fragments/Main.svelte';
	import Period from './fragments/Period.svelte';
	import Tags from './fragments/Tags.svelte';
	export let consultant: ConsultantType;

	let projects: ProjectType[] = consultant.projects;
</script>

<ul>
	{#each projects as { title, description, tags, period }}
		<li>
			<div class="period">
				<Period {period} />
			</div>
			<Main {title} {description} />
			<Tags {tags} />
		</li>
	{/each}
</ul>

<style>
	ul {
		display: flex;
		flex-direction: column;
		margin: 1em 0;
	}
	li + li {
		margin-top: 4em;
	}
	li {
		position: relative;
		padding: 1em;
		display: flex;
		flex-direction: column;
		font-size: 0.9em;
		counter-increment: projex;
	}
	@media (min-width: 1100px) {
		li {
			padding: 1.5em;
		}
	}

	li::before {
		position: absolute;
		box-sizing: border-box;
		border: 1px solid var(--color-accent);
		content: '';
		z-index: -1;
		right: 0;
		top: 0;
		width: 100%;
		height: 100%;
		border-radius: 6px;

		--left: 0.7em;
		--right: calc(var(--left) + 10.3em);

		clip-path: polygon(
			-2% -2%,
			var(--left) -2%,
			var(--left) 10%,
			var(--right) 10%,
			var(--right) -2%,
			102% -2%,
			102% 102%,
			-2% 102%
		);
	}

	.period {
		position: absolute;
		top: -0.7em;
	}
</style>
