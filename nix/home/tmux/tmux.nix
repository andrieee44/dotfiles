{ config, pkgs, lib, ... }:
{
	config.programs.tmux = {
		escapeTime = 0;
		keyMode = "vi";
		historyLimit = 5000;
		clock24 = false;
		baseIndex = 1;
		shortcut = "a";
		shell = lib.optionalString config.programs.zsh.enable "${pkgs.zsh}/bin/zsh";
		sensibleOnTop = false;

		extraConfig = let
			tmux = "${pkgs.tmux}/bin/tmux";
			nerdFont = "#{&&:#{!=:${"\${XDG_SESSION_TYPE}"},tty}, true}";

			mvpane = pane:
			let
				paneStr = builtins.toString pane;
			in "${tmux} breakp -t ':${paneStr}' || ${tmux} joinp -t ':${paneStr}' || true";

			cdpane = pane:
			let
				paneStr = builtins.toString pane;
			in "${tmux} selectw -t ':${paneStr}' || ${tmux} neww -t ':${paneStr}'";
		in lib.mkMerge [
			''
				set -Fg default-terminal "#{?#{!=:${"\${XDG_SESSION_TYPE}"},tty},tmux-256color,screen-16color}"
				set -Fsa terminal-overrides "#{?#{!=:${"\${XDG_SESSION_TYPE}"},tty},#,${"\${TERM}"}:RGB,}"
			''

			(lib.optionalString (builtins.any (plugin:
			plugin.plugin == pkgs.tmuxPlugins.nord
			) config.programs.tmux.plugins) ''
				set -Fg status-left "#[fg=black,bg=cyan,bold] ##S #{?${nerdFont},#[fg=cyan#,bg=black#,nobold],}"
				set -Fg status-right "#{?${nerdFont},#[fg=brightblack#,bg=black]#[fg=white#,bg=brightblack] ${config.customVars.dateFmt} #[fg=cyan]#[fg=black#,bg=cyan#,bold] #{user}@##H ,#[fg=white#,bg=brightblack] ${config.customVars.dateFmt} #[fg=black#,bg=cyan#,bold] #{user}@##H }"

				set -Fg window-status-format "#{?${nerdFont},#[fg=black#,bg=brightblack]#[fg=white] ##I  ##W ##F #[fg=brightblack#,bg=black], #[fg=white#,bg=brightblack]##I ##W ##F}"
				set -Fg window-status-current-format "#{?${nerdFont},#[fg=black#,bg=cyan] ##I  ##W ##F #[fg=cyan#,bg=black], #[fg=black#,bg=cyan]##I ##W ##F}"
				set -g window-status-separator ""
			'')

			''
				set -g status-interval 1
				set -g status-right-length 80

				set -g pane-border-style fg=black,dim,bold
				set -g pane-active-border-style fg=cyan,bold

				set -g popup-border-style fg=cyan,bold

				set -g focus-events on

				set -g prefix2 M-a
				bind M-a send-prefix -2

				bind -n M-i splitw -h
				bind -n M-I splitw -v
				bind -n M-o splitw -fh
				bind -n M-O splitw -fv

				bind -n M-l selectp -L
				bind -n M-h selectp -R
				bind -n M-k selectp -U
				bind -n M-j selectp -D

				bind -n M-L swapp -s "{left-of}"
				bind -n M-H swapp -s "{right-of}"
				bind -n M-J swapp -s "{up-of}"
				bind -n M-K swapp -s "{down-of}"

				bind -n M-C-l resizep -R
				bind -n M-C-h resizep -L
				bind -n M-C-j resizep -D
				bind -n M-C-k resizep -U

				bind -n M-q killp

				bind -n M-! run "${mvpane 1}"
				bind -n M-@ run "${mvpane 2}"
				bind -n M-# run "${mvpane 3}"
				bind -n M-$ run "${mvpane 4}"
				bind -n M-% run "${mvpane 5}"
				bind -n M-^ run "${mvpane 6}"
				bind -n M-& run "${mvpane 7}"
				bind -n M-* run "${mvpane 8}"
				bind -n M-( run "${mvpane 9}"

				bind -n M-Enter neww

				bind -n M-1 run "${cdpane 1}"
				bind -n M-2 run "${cdpane 2}"
				bind -n M-3 run "${cdpane 3}"
				bind -n M-4 run "${cdpane 4}"
				bind -n M-5 run "${cdpane 5}"
				bind -n M-6 run "${cdpane 6}"
				bind -n M-7 run "${cdpane 7}"
				bind -n M-8 run "${cdpane 8}"
				bind -n M-9 run "${cdpane 9}"

				bind -n M-Q killw

				bind -n M-D detach

				bind -n M-R command-prompt -I "#W" "rename-window '%%'"

				bind -n M-[ copy-mode

				bind -n M-d run -b "${config.customVars.fzfscripts.pathmenu}/bin/pathmenu 1>&- 2>/dev/null || true"
				bind -n M-BSpace run -b "${config.customVars.fzfscripts.sysmenu}/bin/sysmenu 1>&- 2>/dev/null || true"

				bind -n M-r source "${config.xdg.configHome}/tmux/tmux.conf"
			''
		];

		plugins = with pkgs; [
			(lib.mkIf (config.customVars.colorscheme == "nord") {
				plugin = tmuxPlugins.nord;
			})
		];
	};
}
