{ config, pkgs, lib, ... }:
{
	config.programs.tmux = {
		escapeTime = 0;
		keyMode = "vi";
		historyLimit = 5000;
		clock24 = false;
		baseIndex = 1;
		shortcut = "a";
		shell = lib.mkIf config.programs.zsh.enable "${pkgs.zsh}/bin/zsh";
		sensibleOnTop = false;

		extraConfig = ''
			set -Fg default-terminal "#{?#{==:${"$TERM"},alacritty},tmux-256color,screen-16color}"
			set -Fsa terminal-overrides "#{?#{==:${"$TERM"},alacritty},#,${"$TERM"}:RGB,}"

			set -g pane-border-style fg=black,dim,bold
			set -g pane-active-border-style fg=cyan,bold

			set -g focus-events on

			set -g prefix2 M-a
			bind M-a send-prefix -2

			bind -n M-i splitw -h
			bind -n M-I splitw -v

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

			bind -n M-! run "tmux breakp -t ':1' || tmux joinp -t ':1'"
			bind -n M-@ run "tmux breakp -t ':2' || tmux joinp -t ':2'"
			bind -n M-# run "tmux breakp -t ':3' || tmux joinp -t ':3'"
			bind -n M-$ run "tmux breakp -t ':4' || tmux joinp -t ':4'"
			bind -n M-% run "tmux breakp -t ':5' || tmux joinp -t ':5'"
			bind -n M-^ run "tmux breakp -t ':6' || tmux joinp -t ':6'"
			bind -n M-& run "tmux breakp -t ':7' || tmux joinp -t ':7'"
			bind -n M-* run "tmux breakp -t ':8' || tmux joinp -t ':8'"
			bind -n M-( run "tmux breakp -t ':9' || tmux joinp -t ':9'"

			bind -n M-Enter neww

			bind -n M-1 run "tmux selectw -t :1 || tmux neww -t :1"
			bind -n M-2 run "tmux selectw -t :2 || tmux neww -t :2"
			bind -n M-3 run "tmux selectw -t :3 || tmux neww -t :3"
			bind -n M-4 run "tmux selectw -t :4 || tmux neww -t :4"
			bind -n M-5 run "tmux selectw -t :5 || tmux neww -t :5"
			bind -n M-6 run "tmux selectw -t :6 || tmux neww -t :6"
			bind -n M-7 run "tmux selectw -t :7 || tmux neww -t :7"
			bind -n M-8 run "tmux selectw -t :8 || tmux neww -t :8"
			bind -n M-9 run "tmux selectw -t :9 || tmux neww -t :9"

			bind -n M-Q killw

			bind -n M-d detach

			bind -n M-R command-prompt -I "#W" "rename-window '%%'"

			bind -n M-[ copy-mode

			bind -n M-r source "${config.xdg.configHome}/tmux/tmux.conf"
		'';

		plugins = with pkgs; [
			{
				plugin = tmuxPlugins.nord;
				extraConfig = ''
					set -g @nord_tmux_no_patched_font 1
					set -g @nord_tmux_show_status_content 1
					set -g @nord_tmux_date_format "(%a) %b %d %Y"
				'';
			}
		];
	};
}
