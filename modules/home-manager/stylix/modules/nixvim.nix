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
				ctermfg = "lightgray";
				italic = true;
			};

			Visual = {
				bg = colors.base03;
				ctermfg = "black";
				ctermbg = "lightgray";
			};
		};

		extraConfigLua = ''
			require('oishiline').setup({
				colors = {
					black = "${colors.base00}",
					red = "${colors.base08}",
					green = "${colors.base0B}",
					yellow = "${colors.base0A}",
					blue = "${colors.base0D}",
					magenta = "${colors.base0E}",
					cyan = "${colors.base0C}",
					white = "${colors.base05}",
					brightblack = "${colors.base03}",
					brightred = "${colors.base08}",
					brightgreen = "${colors.base0B}",
					brightyellow = "${colors.base0A}",
					brightblue = "${colors.base0D}",
					brightmagenta = "${colors.base0E}",
					brightcyan = "${colors.base0C}",
					brightwhite = "${colors.base07}",
				},
			})
		'';
	};
}
