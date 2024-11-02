{ config, pkgs, ... }:
{
  home = {
    username = "andrieee44";
    homeDirectory = "/home/${config.home.username}";

    sessionVariables.SSH_ASKPASS = pkgs.writers.writeDash "ssh_askpass" ''
      	set -eu

      	${config.programs.password-store.package}/bin/pass "ssh/lenovoIdeapadSlim3"
    '';
  };
}
