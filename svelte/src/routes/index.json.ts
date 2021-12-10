import { consultants } from '$lib/db';

export const get = async () => {
	console.log('aaaaaa');

	if (consultants && consultants.length) {
		return { body: { consultants } };
	}
};
