{ config, lib, ... }:
lib.mkIf config.programs.starship.enable {
  xdg.configFile = {
    "starship/gui.toml".text = builtins.readFile ./base.toml + builtins.readFile ./gui.toml;
    "starship/tty.toml".text = builtins.readFile ./base.toml + builtins.readFile ./tty.toml;
  };

  programs.zsh.initExtra = lib.mkIf config.programs.starship.enableZshIntegration ''
    	[ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] && \
    		export STARSHIP_CONFIG="${config.home.homeDirectory}/${
        config.xdg.configFile."starship/tty.toml".target
      }" || \
    		export STARSHIP_CONFIG="${config.home.homeDirectory}/${
        config.xdg.configFile."starship/gui.toml".target
      }"
  '';
}
