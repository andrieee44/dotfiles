{ config, ... }:
let
	colors = config.lib.stylix.colors;
	hashColors = colors.withHashtag;
in {
	programs = {
		mpv.scriptOpts.uosc.color = "foreground=${colors.base05},foreground_text=${colors.base01},background=${colors.base02},background_text=${colors.base05},curtain=${colors.base03},success=${colors.base0B},error=${colors.base08}";
		zsh.autosuggestion.highlight = "$([ \"$XDG_SESSION_TYPE\" = \"tty\" ] && echo 'fg=magenta' || echo 'fg=${hashColors.base0E}')";

		nixvim = {
			highlightOverride = {
				TSComment = {
					fg = hashColors.base04;
					ctermfg = "white";
					italic = true;
				};

				Visual = {
					bg = hashColors.base02;
					ctermfg = "black";
					ctermbg = "white";
				};
			};

			extraConfigLua = ''
				require('oishiline').setup({
					colors = {
						bg = '${hashColors.base01}',
						altBg = '${hashColors.base02}',
						darkFg = '${hashColors.base03}',
						fg = '${hashColors.base04}',
						lightFg = '${hashColors.base05}',
						normal = '${hashColors.base0D}',
						insert = '${hashColors.base0B}',
						visual = '${hashColors.base0E}',
						replace = '${hashColors.base09}',
						command = '${hashColors.base0D}',
						terminal = '${hashColors.base0B}',
					},
				})
			'';
		};
	};

	stylix.targets = {
		firefox.profileNames = [ "default" ];
		mangohud.custom.background_alpha = 0.5;

		custom = {
			aerc.enable = true;
			imv.enable = true;
		};

		tmux = {
			enable = false;
			custom.enable = true;
		};

		fzf = {
			enable = false;
			custom.enable = true;
		};

		nixvim = {
			transparent_bg = {
				main = true;
				sign_column = true;
			};

			custom.transparent_bg = {
				lineNumbers = true;
				otherWindows = true;
			};
		};
	};
}
