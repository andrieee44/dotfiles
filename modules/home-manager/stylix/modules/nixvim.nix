{ config, lib, ... }:
{
	options.stylix.targets.custom.nixvim = {
		enable = lib.mkEnableOption "custom implementation of styling nixvim";

		transparentBackground = {
			lineNumbers = lib.mkEnableOption "background transparency for neovim line numbers";
			otherWindows = lib.mkEnableOption "background transparency for inactive neovim windows";
		};
	};

	config.programs.nixvim = let
		cfg = config.stylix.targets.custom.nixvim;
		colors = config.lib.stylix.colors.withHashtag;
	in lib.mkIf cfg.enable {
		highlight = {
			LineNr = lib.mkIf cfg.transparentBackground.lineNumbers {
				bg = "none";
				ctermbg = "none";
			};

			NormalNC = lib.mkIf cfg.transparentBackground.otherWindows {
				bg = "none";
				ctermbg = "none";
			};
		};

		highlightOverride = let
			comment = {
				fg = colors.base0C;
				ctermfg = "cyan";
				italic = true;
			};
			
			gitComment = comment // { italic = false; };
		in {
			Comment = comment;
			TSComment = comment;
			gitcommitComment = gitComment;
			gitcommitOnBranch = gitComment;

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
