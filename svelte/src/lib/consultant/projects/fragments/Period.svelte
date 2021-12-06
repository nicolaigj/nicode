<script lang="ts">
	export let period: PeriodType;

	const YYYYMM = (d: Date) => {
		const date = new Date(d);
		return date.getFullYear() + '/' + (date.getMonth() + 1);
	};
	let from = YYYYMM(period.from);
	let to = YYYYMM(period.to);
</script>

<span>
	<time datetime={from}>{from}</time>
	-
	{#if period.to}
		<time datetime={to}>{to}</time>
	{:else}
		<time>present</time>
	{/if}
</span>

<style>
	span {
		display: flex;
		gap: 1em;
		font-size: 0.9em;
	}
</style>
