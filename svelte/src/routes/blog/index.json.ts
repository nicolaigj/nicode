import { blogPosts } from '$lib/db';

export const get = async () => {
	const availablePosts: Pick<BlogPostType, 'title' | 'published'>[] = blogPosts
		.filter(({ visible, published }) => {
			const isPublished = new Date().getTime() >= new Date(published).getTime();

			return visible && isPublished;
		})
		.map(({ title, published }) => {
			return { title, published };
		});

	return { body: { availablePosts } };
};
