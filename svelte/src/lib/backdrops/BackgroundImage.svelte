<script lang="ts">
	type BackgroundVariation = 1 | 2 | 3 | 4;
	export let variation: BackgroundVariation = 4;
</script>

<div aria-hidden="true" class="b{variation}" />

<style>
	div {
		height: 100%;
		width: 100vw;
		top: 0;
		left: 0;
		position: fixed;
		z-index: -10;

		background-size: cover;
		background-repeat: no-repeat;
		background-position: center;
		opacity: 0.2;
	}
	.b1 {
		background-image: image-set(url('/bgs/opt1.webp') 1x, url('/bgs/opt1.jpg') 1x);
		background-image: -webkit-image-set(url('/bgs/opt1.webp') 1x, url('/bgs/opt1.jpg') 1x);
	}
	.b2 {
		background-image: image-set(url('/bgs/opt2.webp') 1x, url('/bgs/opt2.jpg') 1x);
		background-image: -webkit-image-set(url('/bgs/opt2.webp') 1x, url('/bgs/opt2.jpg') 1x);
	}
	.b3 {
		background-image: image-set(url('/bgs/opt3.webp') 1x, url('/bgs/opt3.jpg') 1x);
		background-image: -webkit-image-set(url('/bgs/opt3.webp') 1x, url('/bgs/opt3.jpg') 1x);
	}

	.b4 {
		background-image: image-set(url('/bgs/opt4.webp') 1x, url('/bgs/opt4.jpg') 1x);
		background-image: -webkit-image-set(url('/bgs/opt4.webp') 1x, url('/bgs/opt4.jpg') 1x);
	}

	@media (prefers-color-scheme: dark) {
		div {
			opacity: 0.15;
		}
	}
</style>
