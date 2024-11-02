{ config, pkgs, ... }:
{
  stylix.targets = {
    gnome.enable = false;
    gtk.enable = false;
  };

  home = {
    username = "nix-on-droid";
    homeDirectory = "/data/data/com.termux.nix/files/home";

    sessionVariables.SSH_ASKPASS = pkgs.writers.writeDash "ssh_askpass" ''
      set -eu

      ${config.programs.password-store.package}/bin/pass "ssh/oppoReno8Z"
    '';
  };
}
