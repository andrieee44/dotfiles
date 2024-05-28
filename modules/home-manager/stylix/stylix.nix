{ config, ... }:
let
	colors = config.lib.stylix.colors;
	hashColors = colors.withHashtag;
in {
	programs = {
		mpv.scriptOpts.uosc.color = "foreground=${colors.base05},foreground_text=${colors.base01},background=${colors.base02},background_text=${colors.base05},curtain=${colors.base03},success=${colors.base0B},error=${colors.base08}";
		zsh.autosuggestion.highlight = "$([ \"$XDG_SESSION_TYPE\" = \"tty\" ] && echo 'fg=magenta' || echo 'fg=${hashColors.base0E}')";

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

		imv.settings.options = {
			overlay_text_color = hashColors.base05;
			overlay_background_color = hashColors.base02;
			background = hashColors.base01;
		};

		tmux.extraConfig = let
			guiBool = "#{!=:${"\${XDG_SESSION_TYPE}"},tty}";
			gui = t: f: "#{?${guiBool},${t},${f}}";
			bell = t: f: "#{?window_bell_flag,${t},${f}}";
			normalFg = gui hashColors.base05 "white";
			normalBg = gui hashColors.base0D "blue";
			bellBg = gui hashColors.base08 "red";
		in ''
			set -g window-status-activity-style "fg=${normalFg},bg=${hashColors.base01}"
			set -g message-command-style 'fg=${hashColors.base06},bg=${hashColors.base02}'
			set -g pane-border-style 'fg=${hashColors.base03}'
			set -g pane-active-border-style "fg=${normalBg}"
			set -g mode-style "fg=${hashColors.base01},bg=${normalFg}"

			set -g status-left "#[fg=${hashColors.base01},bg=${normalBg},bold] #S #[fg=${normalBg},bg=${hashColors.base01}]${gui "" " "}"

			set -g status-right "#[fg=${hashColors.base02},bg=${hashColors.base01}]${gui "" ""}#[fg=${normalFg},bg=${hashColors.base02}] ${gui "󰥔 " ""}%b %e %Y (%a) %l:%M %p #[fg=${normalBg},bg=${hashColors.base02}]${gui "" ""}#[fg=${hashColors.base01},bg=${normalBg},bold] ${gui " " ""}#{user}@#H "

			set -g window-status-current-format "#[fg=${hashColors.base01},bg=${normalBg}]${gui "" ""}#[fg=${hashColors.base01},bg=${normalBg},bold] #I ${gui "" "|"} #W #[fg=${normalBg},bg=${hashColors.base01}]${gui "" " "}"

			set -g window-status-format "#[fg=${hashColors.base01},bg=${bell bellBg hashColors.base02}]${gui "" ""}#[fg=${bell hashColors.base01 normalFg},bg=${bell "${bellBg}#,bold" "${hashColors.base02}#,nobold"}] #I ${gui "" "|"} #W #[fg=${bell bellBg hashColors.base02},bg=${hashColors.base01}]${gui "" " "}"
		'';

		aerc.stylesets.default = ''
			*.selected.bg=8
			*.selected.bold=true
			statusline_default.bold=true
			border.reverse=false
			part_mimetype.dim=false

			border.fg=3
			error.fg=1
			warning.fg=3
			success.fg=2
			statusline_default.bg=0
			statusline_default.fg=4
			statusline_error.fg=1
			statusline_warning.fg=3
			msglist_deleted.fg=8
			msglist_deleted.selected.fg=8
			msglist_deleted.selected.bg=0
			msglist_result.fg=2
			msglist_result.selected.fg=2
			msglist_result.selected.bg=0
			msglist_marked.fg=4
			msglist_marked.selected.fg=4
			msglist_marked.selected.bg=0
			msglist_flagged.fg=2
			msglist_flagged.selected.fg=2
			msglist_flagged.selected.bg=0
			msglist_unread.fg=6
			msglist_unread.selected.fg=6
			msglist_unread.selected.bg=0
			tab.fg=8
			tab.bg=7
			tab.selected.bg=4
			tab.selected.fg=0
			dirlist_unread.fg=4
			dirlist_unread.selected.fg=4
			dirlist_unread.selected.bg=0
			dirlist_recent.fg=4
			dirlist_recent.selected.fg=4
			dirlist_recent.selected.bg=0
			part_mimetype.fg=7
			part_mimetype.selected.fg=4
			part_mimetype.selected.bg=0
			part_switcher.bg=0
			part_switcher.selected.fg=4
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
