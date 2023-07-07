{ config, ... }:
{
	config.programs.fzf = {
		defaultOptions = [
			"--exact"
			"--reverse"
			"--info inline"
			"--header-first"
			"--header 'Search file:'"
			"--tabstop 4"
			"--no-mouse"
			"--preview-window border-left,wrap"
		];

		colors = let
			colorschemes = {
				nord = {
					fg = "7";
					preview-fg = "7";
					preview-bg = "0";
					hl = "4";
					"fg+" = "7";
					"bg+" = "0";
					gutter = "0";
					"hl+" = "4";
					query = "7";
					disabled = "8";
					info = "6";
					separator = "6";
					border = "6";
					spinner = "6";
					label = "6";
					prompt = "6";
					pointer = "6";
					marker = "6";
					header = "6";
				};
			};
		in colorschemes.${config.customVars.colorscheme};
	};
}
