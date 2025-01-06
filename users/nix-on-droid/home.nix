{
  config,
  pkgs,
  lib,
  ...
}:
{
  stylix.targets = {
    gnome.enable = false;
    gtk.enable = false;
  };

  programs = {
    bash.enable = lib.mkForce false;
    notmuch.enable = lib.mkForce false;

    nixvim.plugins = {
      cmp.enable = lib.mkForce false;
      colorizer.enable = lib.mkForce false;
      lsp.enable = lib.mkForce false;
      luasnip.enable = lib.mkForce false;
      treesitter.enable = lib.mkForce false;
    };

    zsh.initExtra =
      let
        ssh = "${config.programs.ssh.package}/bin";
      in
      ''
        eval "$(${ssh}/ssh-agent -s)" > /dev/null && ${ssh}/ssh-add > /dev/null 2>& 1
      '';
  };

  home = {
    username = "nix-on-droid";
    homeDirectory = "/data/data/com.termux.nix/files/home";

    sessionVariables.SSH_ASKPASS = pkgs.writers.writeDash "ssh_askpass" ''
      set -eu

      ${config.programs.password-store.package}/bin/pass ssh/oppoReno8Z
    '';
  };
}
