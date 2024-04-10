{ config, lib, ... }:
{
	xdg.configFile = let
		base = config.xdg.configFile."starship.toml".source;
	in {
		"starship/gui.toml".text = builtins.readFile base + builtins.readFile ./gui.toml;
		"starship/tty.toml".text = builtins.readFile base + builtins.readFile ./tty.toml;

		"starship.toml" = {
			source = ./base.toml;
			target = "starship/base.toml";
		};
	};

	programs.zsh.initExtra = let
		cfg = config.programs.starship;
	in lib.mkIf cfg.enableZshIntegration ''
		[ "$XDG_SESSION_TYPE" = "tty" ] && \
			export STARSHIP_CONFIG="${config.home.homeDirectory}/${config.xdg.configFile."starship/tty.toml".target}" || \
			export STARSHIP_CONFIG="${config.home.homeDirectory}/${config.xdg.configFile."starship/gui.toml".target}"
	'';
}
