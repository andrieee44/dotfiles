{ config, ... }:
let
	colors = config.lib.stylix.colors;
	hashColors = colors.withHashtag;
in {
	programs = {
		mpv.scriptOpts.uosc.color = "foreground=${colors.base05},foreground_text=${colors.base01},background=${colors.base02},background_text=${colors.base05},curtain=${colors.base03},success=${colors.base0B},error=${colors.base08}";
		zsh.autosuggestion.highlight = "fg=${hashColors.base0E}";

		fzf.colors = {
			fg = hashColors.base04;
			hl = hashColors.base0D;
			"fg+" = hashColors.base06;
			"bg+" = hashColors.base00;
			info = hashColors.base0A;
			border = hashColors.base0D;
			prompt = hashColors.base0A;
			pointer = hashColors.base0C;
			marker = hashColors.base0C;
			spinner = hashColors.base0C;
			header = hashColors.base0D;
		};

		nixvim = {
			highlightOverride.TSComment = {
				fg = hashColors.base04;
				ctermfg = "white";
				italic = true;
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

		imv.settings.options = {
			overlay_text_color = hashColors.base05;
			overlay_background_color = hashColors.base02;
			background = hashColors.base01;
		};

		tmux.extraConfig = let
			guiBool = "#{!=:${"\${XDG_SESSION_TYPE}"},tty}";
			gui = t: f: "#{?${guiBool},${t},${f}}";
			bell = t: f: "#{?window_bell_flag,${t},${f}}";
		in ''
			set -g window-status-activity-style 'fg=${hashColors.base05},bg=${hashColors.base01}'
			set -g message-command-style 'fg=${hashColors.base06},bg=${hashColors.base02}'
			set -g pane-border-style 'fg=${hashColors.base03}'
			set -g pane-active-border-style 'fg=${hashColors.base0D}'

			set -g status-left "#[fg=${hashColors.base01},bg=${hashColors.base0D},bold] #S #[fg=${hashColors.base0D},bg=${hashColors.base01}]${gui "" " "}"

			set -g status-right "#[fg=${hashColors.base02},bg=${hashColors.base01}]${gui "" ""}#[fg=${hashColors.base05},bg=${hashColors.base02}] ${gui "󰥔" ""} %b %e %Y (%a) %l:%M %p #[fg=${hashColors.base0D},bg=${hashColors.base02}]${gui "" ""}#[fg=${hashColors.base01},bg=${hashColors.base0D},bold] ${gui " " ""}#{user}@#H "

			set -g window-status-current-format "#[fg=${hashColors.base01},bg=${hashColors.base0D}]${gui "" ""}#[fg=${hashColors.base01},bg=${hashColors.base0D},bold] #I ${gui "" "|"} #W #[fg=${hashColors.base0D},bg=${hashColors.base01}]${gui "" " "}"

			set -g window-status-format "#[fg=${hashColors.base01},bg=${bell "${hashColors.base08}" "${hashColors.base02}"}]${gui "" ""}#[fg=${bell "${hashColors.base01}" "${hashColors.base05}"},bg=${bell "${hashColors.base08}#,bold" "${hashColors.base02}#,nobold"}] #I ${gui "" "|"} #W #[fg=${bell "${hashColors.base08}" "${hashColors.base02}"},bg=${hashColors.base01}]${gui "" " "}"
		'';
	};

	stylix.targets = {
		firefox.profileNames = [ "default" ];

		nixvim.transparent_bg = {
			main = true;
			sign_column = true;
			lineNumbers = true;
			otherWindows = true;
		};
	};
}
