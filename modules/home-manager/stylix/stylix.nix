{ config, ... }:
{
	programs.fzf.colors = let
		colors = config.lib.stylix.colors.withHashtag;
	in {
		fg = colors.base04;
		hl = colors.base0D;
		"fg+" = colors.base06;
		"bg+" = colors.base00;
		info = colors.base0A;
		border = colors.base0D;
		prompt = colors.base0A;
		pointer = colors.base0C;
		marker = colors.base0C;
		spinner = colors.base0C;
		header = colors.base0D;
	};

	stylix.targets = {
		firefox.profileNames = [ "default" ];

		nixvim.transparent_bg = {
			main = true;
			sign_column = true;
		};
	};
}
