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
			"bg+" = "0";
			fg = "7";
			"fg+" = "7";
			hl = "4";
			"hl+" = "4";
			spinner = "5";
			header = "2";
			info = "3";
			pointer = "5";
			marker = "2";
			prompt = "5";
		};
	};
}
