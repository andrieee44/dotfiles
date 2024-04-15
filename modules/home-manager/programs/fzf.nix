{ colorscheme, ... }:
{
	programs.fzf = {
		colors = {
			fg = "#${colorscheme.palette.base04}";
			hl = "#${colorscheme.palette.base0D}";
			"fg+" = "#${colorscheme.palette.base06}";
			"bg+" = "#${colorscheme.palette.base01}";
			info = "#${colorscheme.palette.base0A}";
			border = "#${colorscheme.palette.base0D}";
			prompt = "#${colorscheme.palette.base0A}";
			pointer = "#${colorscheme.palette.base0C}";
			marker = "#${colorscheme.palette.base0C}";
			spinner = "#${colorscheme.palette.base0C}";
			header = "#${colorscheme.palette.base0D}";
		};

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
	};
}
