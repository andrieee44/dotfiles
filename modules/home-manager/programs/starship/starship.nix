{ config, pkgs, lib, colorscheme, ... }:
{
	xdg.configFile = let
		base = config.xdg.configFile."starship.toml".source;
	in {
		"starship.toml".target = "starship/base.toml";
		"starship/gui.toml".text = (builtins.readFile base) + (builtins.readFile ./gui.toml);
		"starship/tty.toml".text = (builtins.readFile base) + (builtins.readFile ./tty.toml);
	};

	programs = let
		cfg = config.programs.starship;
	in {

		zsh.initExtra = lib.mkIf cfg.enableZshIntegration ''
			[ "$XDG_SESSION_TYPE" = "tty" ] && \
				export STARSHIP_CONFIG="${config.home.homeDirectory}/${config.xdg.configFile."starship/tty.toml".target}" || \
				export STARSHIP_CONFIG="${config.home.homeDirectory}/${config.xdg.configFile."starship/gui.toml".target}"
		'';

		starship.settings = {
			add_newline = false;
		};
	};
}
