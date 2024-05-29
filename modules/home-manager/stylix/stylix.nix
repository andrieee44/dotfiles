{ config, lib, ... }:
let
	colors = config.lib.stylix.colors;
	hashColors = colors.withHashtag;
in {
	programs = {
		mpv.scriptOpts.uosc.color = "foreground=${colors.base05},foreground_text=${colors.base01},background=${colors.base02},background_text=${colors.base05},curtain=${colors.base03},success=${colors.base0B},error=${colors.base08}";
		zsh.autosuggestion.highlight = "$([ \"$XDG_SESSION_TYPE\" = \"tty\" ] && echo 'fg=magenta' || echo 'fg=${hashColors.base0E}')";
		mangohud.settings.background_alpha = lib.mkForce 0.5;

		fzf.colors = {
			fg = "white";
			hl = "blue";
			"fg+" = "bright-white";
			"bg+" = "black";
			info = "yellow";
			border = "blue";
			prompt = "yellow";
			pointer = "cyan";
			marker = "cyan";
			spinner = "cyan";
			header = "blue";
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
		in ''
			set -g status-style 'fg=white,bg=black'
			set -g pane-border-style 'fg=brightblack'
			set -g pane-active-border-style 'fg=blue'
			set -g mode-style 'fg=black,bg=white'
			set -g message-style 'fg=white,bg=black'
			set -g message-command-style 'fg=white,bg=brightblack'
			set -g clock-mode-colour 'green'
			set -g status-left "#[fg=black,bg=blue,bold] #S #[fg=blue,bg=black]${gui "" " "}"
			set -g status-right "#[fg=brightblack,bg=black]${gui "" ""}#[fg=white,bg=brightblack] ${gui "󰥔 " ""}%b %e %Y (%a) %l:%M %p #[fg=blue,bg=brightblack]${gui "" ""}#[fg=black,bg=blue,bold] ${gui " " ""}#{user}@#H "
			set -g window-status-current-format "#[fg=black,bg=blue]${gui "" ""}#[fg=black,bg=blue,bold] #I ${gui "" "|"} #W #[fg=blue,bg=black]${gui "" " "}"
			set -g window-status-format "#[fg=black,bg=${bell "red" "brightblack"}]${gui "" ""}#[fg=${bell "black" "white"},bg=${bell "red#,bold" "brightblack#,nobold"}] #I ${gui "" "|"} #W #[fg=${bell "red" "brightblack"},bg=black]${gui "" " "}"
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
		tmux.enable = false;

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
