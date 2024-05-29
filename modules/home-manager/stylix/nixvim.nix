{ config, lib, ... }:
{
	options.stylix.targets.custom.nixvim = {
		enable = lib.mkEnableOption "custom implementation of styling nixvim";

		transparent_bg = {
			lineNumbers = lib.mkEnableOption "background transparency for neovim line numbers";
			otherWindows = lib.mkEnableOption "background transparency for inactive neovim windows";
		};
	};

	config.programs.nixvim = let
		cfg = config.stylix.targets.custom.nixvim;
		colors = config.lib.stylix.colors.withHashtag;
	in lib.mkIf cfg.enable {
		highlight = {
			LineNr = lib.mkIf cfg.transparent_bg.lineNumbers {
				bg = "none";
				ctermbg = "none";
			};

			NormalNC = lib.mkIf cfg.transparent_bg.otherWindows {
				bg = "none";
				ctermbg = "none";
			};
		};

		highlightOverride = {
			TSComment = {
				fg = colors.base04;
				ctermfg = "white";
				italic = true;
			};

			Visual = {
				bg = colors.base02;
				ctermfg = "black";
				ctermbg = "white";
			};
		};

		extraConfigLua = ''
			require('oishiline').setup({
				colors = {
					bg = '${colors.base01}',
					altBg = '${colors.base02}',
					darkFg = '${colors.base03}',
					fg = '${colors.base04}',
					lightFg = '${colors.base05}',
					normal = '${colors.base0D}',
					insert = '${colors.base0B}',
					visual = '${colors.base0E}',
					replace = '${colors.base09}',
					command = '${colors.base0D}',
					terminal = '${colors.base0B}',
				},
			})
		'';
	};
}
