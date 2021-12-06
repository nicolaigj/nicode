/// <reference types="@sveltejs/kit" />

type ConsultantType = {
	name: string;
	headshot: string;
	contact: ContactType;
	preamble: string;
	availability: string;
	focus: string;
	projects: ProjectType[];
};

type ContactType = {
	email: string;
	mobile: string;
	linkedin: string;
};

type ProjectType = {
	title: string;
	description: string;
	period: Period;
	tags: string[];
};

type PeriodType = {
	from: Date;
	to: Date;
};
