{ config, ... }:
{
	config.programs.fzf = {
		defaultOptions = [
			"--exact"
			"--reverse"
			"--info inline"
			"--header-first"
			"--header 'Search file'"
			"--tabstop 4"
			"--no-mouse"
			"--preview-window border-left,wrap"
		];

		colors = {
			"bg+" = "#3b4252";
			spinner = "#81a1c1";
			hl = "#616e88";
			fg = "#d8dee9";
			header = "#81a1c1";
			info = "#88c0d0";
			pointer = "#81a1c1";
			marker = "#81a1c1";
			"fg+" = "#d8dee9";
			prompt = "#81a1c1";
			"hl+" = "#81a1c1";
		};
	};
}
