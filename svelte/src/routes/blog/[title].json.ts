import { blogPosts } from '$lib/db';

export const get = async ({ params }) => {
	const slug = params.title.toLowerCase();

	const post: BlogPostType = blogPosts.find(({ title, visible, published }) => {
		const match = title.toLowerCase() === slug;
		const isPublished = new Date().getTime() >= new Date(published).getTime();

		return match && visible && isPublished;
	});

	if (post) {
		return { body: { post } };
	}
};
