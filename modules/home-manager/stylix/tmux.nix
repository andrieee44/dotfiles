{ config, lib, ... }:
{
	options.stylix.targets.tmux.custom.enable = lib.mkEnableOption "custom implementation of stylix.targets.tmux";

	config.programs.tmux.extraConfig = let
		guiBool = "#{!=:${"\${XDG_SESSION_TYPE}"},tty}";
		gui = t: f: "#{?${guiBool},${t},${f}}";
		bell = t: f: "#{?window_bell_flag,${t},${f}}";
	in lib.mkIf config.stylix.targets.tmux.custom.enable ''
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
}
