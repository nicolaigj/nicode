<script lang="ts">
	import SvgFilter from './_SvgFilter.svelte';
	export let consultant: ConsultantType;
</script>

<SvgFilter />

<div>
	<img src={consultant.headshot} alt="consultant {consultant.name}" width="500px" height="500px" />
</div>

<style>
	div {
		display: flex;
		align-items: center;
		justify-content: center;
		position: relative;

		width: clamp(180px, 70%, 380px);
		height: 100%;

		border: 2px solid var(--color-accent);
		border-radius: 9999px;
		overflow: hidden;

		background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24'%3E%3Cpath fill='rgba(0,0,0,0.05)' d='M12,4A4,4 0 0,1 16,8A4,4 0 0,1 12,12A4,4 0 0,1 8,8A4,4 0 0,1 12,4M12,14C16.42,14 20,15.79 20,18V20H4V18C4,15.79 7.58,14 12,14Z' /%3E%3C/svg%3E");
		background-size: 130%;
		background-position: center 25%;
		background-repeat: no-repeat;
	}

	img {
		width: 100%;
		object-fit: cover;
		height: min-content;

		display: flex;
		justify-content: center;
		align-items: center;

		/* hack to hide alt text if load fail (aviid layout shift uglyness) */
		color: rgba(0, 0, 0, 0);
		animation: fadeInAlt 0.2s 0.3s ease-in-out forwards;

		/* blue tint */
		filter: sepia(1) hue-rotate(170deg) grayscale(0.7);
	}
	@keyframes fadeInAlt {
		to {
			color: var(--color-content);
		}
	}
	@media (max-width: 600px) {
		div {
			border-radius: 6px;
			max-width: 300px;
		}
	}
</style>
