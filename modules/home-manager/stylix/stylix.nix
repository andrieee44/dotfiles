{ config, ... }:
let
	colors = config.lib.stylix.colors;
	hashColors = colors.withHashtag;
in {
	programs = {
		mpv.scriptOpts.uosc.color = "foreground=${colors.base05},foreground_text=${colors.base01},background=${colors.base02},background_text=${colors.base05},curtain=${colors.base03},success=${colors.base0B},error=${colors.base08}";
		zsh.autosuggestion.highlight = "$([ \"$XDG_SESSION_TYPE\" = \"tty\" ] && echo 'fg=magenta' || echo 'fg=${hashColors.base0E}')";
	};

	stylix.targets = {
		firefox.profileNames = [ "default" ];

		custom = {
			aerc.enable = true;
			imv.enable = true;

			nixvim = {
				enable = true;

				transparent_bg = {
					lineNumbers = true;
					otherWindows = true;
				};
			};

			mangohud = {
				enable = true;
				background_alpha = 0.5;
			};

			tmux.enable = true;
			fzf.enable = true;
		};

		tmux.enable = false;
		fzf.enable = false;

		nixvim.transparent_bg = {
			main = true;
			sign_column = true;
		};
	};
}
