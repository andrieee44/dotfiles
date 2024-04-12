{ config, pkgs, lib, colorscheme, ... }:
{
	programs = let
		tmux = "${pkgs.tmux}/bin/tmux";
	in {
		tmux = {
			baseIndex = 1;
			clock24 = false;
			escapeTime = 0;
			historyLimit = 5000;
			keyMode = "vi";
			mouse = false;
			sensibleOnTop = false;

			extraConfig = let
				guiBool = "#{!=:${"\${XDG_SESSION_TYPE}"},tty}";
				gui = t: f: "#{?${guiBool},${t},${f}}";
				bell = t: f: "#{?window_bell_flag,${t},${f}}";
				baseIndex = builtins.toString config.programs.tmux.baseIndex;
				nextIndex = builtins.toString (config.programs.tmux.baseIndex + 1);

				mvpane = window:
					let
						windowStr = builtins.toString window;
					in "${tmux} breakp -t \":${windowStr}\" || ${tmux} joinp -t \":${windowStr}\" && ${tmux} selectl main-vertical";

				cdwindow = window:
					let
						windowStr = builtins.toString window;
					in "${tmux} selectl -t \":${windowStr}\" main-vertical && ${tmux} selectw -t \":${windowStr}\" || ${tmux} neww -t \":${windowStr}\"";
			in ''
				%if "${guiBool}"
					set -g default-terminal 'tmux-256color'
					set -Fga terminal-features "#,\${"\${TERM}"}:RGB"
					set -g mode-style 'fg=#${colorscheme.palette.base05},bg=#${colorscheme.palette.base03}'
				%else
					set -g default-terminal 'screen-16color'
					set -g mode-style 'fg=#${colorscheme.palette.base00},bg=#${colorscheme.palette.base05}'
				%endif

				set -g focus-events on

				set -g main-pane-width 50%

				set -g message-style 'fg=#${colorscheme.palette.base05},bg=#${colorscheme.palette.base03}'
				set -g message-command-style 'fg=#${colorscheme.palette.base05},bg=#${colorscheme.palette.base03}'

				set -g pane-border-style 'fg=#${colorscheme.palette.base03}'
				set -g pane-active-border-style 'fg=#${colorscheme.palette.base0C}'

				set -g status-style 'fg=#${colorscheme.palette.base05},bg=#${colorscheme.palette.base00}'
				set -g status-left "#[fg=#${colorscheme.palette.base00},bg=#${colorscheme.palette.base0C},bold] #S #[fg=#${colorscheme.palette.base0C},bg=#${colorscheme.palette.base00},nobold,noitalics,nounderscore]${gui "" " "}"
				set -g status-right "#[fg=#${colorscheme.palette.base03},bg=#${colorscheme.palette.base00},nobold,nounderscore,noitalics]${gui "" ""}#[fg=#${colorscheme.palette.base05},bg=#${colorscheme.palette.base03}] %b %e %Y (%a) %l:%M %p #[fg=#${colorscheme.palette.base0C},bg=#${colorscheme.palette.base03},nobold,noitalics,nounderscore]${gui "" ""}#[fg=#${colorscheme.palette.base00},bg=#${colorscheme.palette.base0C},bold] #H "

				set -g window-status-current-format "#[fg=#${colorscheme.palette.base00},bg=#${colorscheme.palette.base0C},nobold,noitalics,nounderscore]${gui "" ""}#[fg=#${colorscheme.palette.base00},bg=#${colorscheme.palette.base0C},bold] #I ${gui "" "|"} #W #[fg=#${colorscheme.palette.base0C},bg=#${colorscheme.palette.base00},nobold,noitalics,nounderscore]${gui "" " "}"
				set -g window-status-format "#[fg=#${colorscheme.palette.base00},bg=${bell "#${colorscheme.palette.base08}" "#${colorscheme.palette.base03}"},nobold,noitalics,nounderscore]${gui "" ""}#[fg=#${colorscheme.palette.base05},bg=${bell "#${colorscheme.palette.base08}#,bold" "#${colorscheme.palette.base03}#,nobold"}] #I ${gui "" "|"} #W #[fg=${bell "#${colorscheme.palette.base08}" "#${colorscheme.palette.base03}"},bg=#${colorscheme.palette.base00},nobold,noitalics,nounderscore]${gui "" " "}"
				set -g window-status-separator ${"''"}
				set -g window-status-bell-style ${"''"}

				bind -n M-i {
					splitw -t :.${baseIndex}
    				swapp -s :.${baseIndex} -t :.${nextIndex}
					selectl main-vertical
				}

				bind -n M-j selectp -t :.+
				bind -n M-k selectp -t :.-

				bind -n M-Space run '[ "$(${tmux} display -p "#P")" = "${baseIndex}" ] && ${tmux} swapp -s :.${nextIndex} || ${tmux} swapp -s :.${baseIndex}'

				bind -n M-q {
					killp
					selectl main-vertical
				}

				bind -n M-1 run '${cdwindow 1}'
				bind -n M-2 run '${cdwindow 2}'
				bind -n M-3 run '${cdwindow 3}'
				bind -n M-4 run '${cdwindow 4}'
				bind -n M-5 run '${cdwindow 5}'
				bind -n M-6 run '${cdwindow 6}'
				bind -n M-7 run '${cdwindow 7}'
				bind -n M-8 run '${cdwindow 8}'
				bind -n M-9 run '${cdwindow 9}'
				bind -n M-0 run '${cdwindow 10}'

				bind -n M-! run '${mvpane 1}'
				bind -n M-@ run '${mvpane 2}'
				bind -n M-# run '${mvpane 3}'
				bind -n M-$ run '${mvpane 4}'
				bind -n M-% run '${mvpane 5}'
				bind -n M-^ run '${mvpane 6}'
				bind -n M-& run '${mvpane 7}'
				bind -n M-* run '${mvpane 8}'
				bind -n M-( run '${mvpane 9}'
				bind -n M-) run '${mvpane 10}'

				bind -n M-Q killw

				bind -n M-D detach

				bind -n M-R command-prompt -I '#W' 'rename-window "%%"'

				bind -n M-[ copy-mode
				bind -n M-] pasteb

				bind -n M-d run -b 'exec $(${config.sh.pathmenu}) 1>& - 2> /dev/null || true'
				bind -n M-BSpace run -b '${config.sh.sysmenu} 1>& - 2> /dev/null || true'
			'';
		};

		zsh.initExtra = lib.mkIf config.programs.tmux.enable ''
			case $- in
				*i*)
					[ -z "$TMUX" ] && { ${tmux} attach || ${tmux} new }
					;;
			esac
		'';
	};
}
