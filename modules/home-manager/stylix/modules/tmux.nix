{ config, lib, ... }:
{
	options.stylix.targets.custom.tmux.enable = lib.mkEnableOption "custom implementation of styling tmux";

	config.programs.tmux.extraConfig = let
		colors = config.lib.stylix.colors.withHashtag;
		guiBool = "#{!=:${"\${XDG_SESSION_TYPE}"},tty}";
		gui = t: f: "#{?${guiBool},${t},${f}}";
		bell = t: f: "#{?window_bell_flag,${t},${f}}";
	in lib.mkIf config.stylix.targets.custom.tmux.enable ''
		set -g status-style 'fg=${colors.base05},bg=${colors.base00}'
		set -g window-status-bell-style 'fg=${colors.base00},bg=${colors.base08}'
		set -g pane-border-style 'fg=${colors.base03}'
		set -g pane-active-border-style 'fg=${colors.base0D}'
		set -g mode-style 'fg=${colors.base00},bg=${colors.base05}'
		set -g message-style 'fg=${colors.base05},bg=${colors.base00}'
		set -g message-command-style 'fg=${colors.base05},bg=${colors.base03}'
		set -g clock-mode-colour '${colors.base0D}'
		set -g status-left "#[fg=${colors.base00},bg=${colors.base0D},bold] #S #[fg=${colors.base0D},bg=${colors.base00}]${gui "" " "}"
		set -g status-right "#[fg=${colors.base03},bg=${colors.base00}]${gui "" ""}#[fg=${colors.base05},bg=${colors.base03}] ${gui "󰥔 " ""}%b %e %Y (%a) %l:%M %p #[fg=${colors.base0D},bg=${colors.base03}]${gui "" ""}#[fg=${colors.base00},bg=${colors.base0D},bold] ${gui " " ""}#{user}@#H "
		set -g window-status-current-format "#[fg=${colors.base00},bg=${colors.base0D}]${gui "" ""}#[fg=${colors.base00},bg=${colors.base0D},bold] #I ${gui "" "|"} #W #[fg=${colors.base0D},bg=${colors.base00}]${gui "" " "}"
		set -g window-status-format "#[fg=${colors.base00},bg=${bell "${colors.base08}" "${colors.base03}"}]${gui "" ""}#[fg=${bell "${colors.base00}" "white"},bg=${bell "${colors.base08}#,bold" "${colors.base03}#,nobold"}] #I ${gui "" "|"} #W #[fg=${bell "${colors.base08}" "${colors.base03}"},bg=${colors.base00}]${gui "" " "}"
	'';
}
