import type { HandleError } from '@sveltejs/kit';
export const handleError: HandleError = async (cat) => {
	console.log(cat);
	// { error, request, frame}
};
