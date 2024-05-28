{ config, pkgs, lib, ... }:
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
				colors = config.lib.stylix.colors.withHashtag;

				mvpane = window:
					let
						windowStr = builtins.toString window;
					in "${tmux} breakp -t :${windowStr} || ${tmux} joinp -bt :${windowStr}.${baseIndex} && ${tmux} selectl main-vertical || true";

				cdwindow = window:
					let
						windowStr = builtins.toString window;
					in "${tmux} selectw -t :${windowStr} || ${tmux} neww -t :${windowStr}";
			in ''
				%if "${guiBool}"
					set -g default-terminal tmux-256color
					set -sa terminal-features ",${"\${TERM}"}:RGB"
				%else
					set -g default-terminal screen-16color
				%endif

				set -g focus-events on

				set -g main-pane-width 50%

				set -g window-status-activity-style 'fg=${colors.base05},bg=${colors.base01}'
				set -g message-command-style 'fg=${colors.base06},bg=${colors.base02}'
				set -g window-status-separator ${"''"}
				set -g status on
				set -g status-left-length 80
				set -g status-right-length 80
				set -g pane-border-style 'fg=${colors.base03}'
				set -g pane-active-border-style 'fg=${colors.base0D}'

				set -g status-left "#[fg=${colors.base01},bg=${colors.base0D},bold] #S #[fg=${colors.base0D},bg=${colors.base01}]${gui "" " "}"

				set -g status-right "#[fg=${colors.base02},bg=${colors.base01}]${gui "" ""}#[fg=${colors.base05},bg=${colors.base02}] ${gui "󰥔" ""} %b %e %Y (%a) %l:%M %p #[fg=${colors.base0D},bg=${colors.base02}]${gui "" ""}#[fg=${colors.base01},bg=${colors.base0D},bold] ${gui " " ""}#{user}@#H "

				set -g window-status-current-format "#[fg=${colors.base01},bg=${colors.base0D}]${gui "" ""}#[fg=${colors.base01},bg=${colors.base0D},bold] #I ${gui "" "|"} #W #[fg=${colors.base0D},bg=${colors.base01}]${gui "" " "}"

				set -g window-status-format "#[fg=${colors.base01},bg=${bell "${colors.base08}" "${colors.base02}"}]${gui "" ""}#[fg=${bell "${colors.base01}" "${colors.base05}"},bg=${bell "${colors.base08}#,bold" "${colors.base02}#,nobold"}] #I ${gui "" "|"} #W #[fg=${bell "${colors.base08}" "${colors.base02}"},bg=${colors.base01}]${gui "" " "}"

				bind -n M-Enter {
					splitw -t :.${baseIndex}
					swapp -s :.${baseIndex} -t :.${nextIndex}
					selectl main-vertical
				}

				bind -n M-h run 'w="$(${tmux} display -p "#{main-pane-width}")" && ${tmux} set -g main-pane-width "$((${"\${w%%%}"} - 2))%" && ${tmux} selectl main-vertical'
				bind -n M-j selectp -t :.+
				bind -n M-k selectp -t :.-
				bind -n M-l run 'w="$(${tmux} display -p "#{main-pane-width}")" && ${tmux} set -g main-pane-width "$((${"\${w%%%}"} + 2))%" && ${tmux} selectl main-vertical'
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
