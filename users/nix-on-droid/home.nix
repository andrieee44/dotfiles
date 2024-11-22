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
    notmuch.enable = lib.mkForce false;

    nixvim.plugins = {
      cmp.enable = lib.mkForce false;
      nvim-colorizer.enable = lib.mkForce false;
      lsp.enable = lib.mkForce false;
      luasnip.enable = lib.mkForce false;
      treesitter.enable = lib.mkForce false;
    };
  };

  home = {
    username = "nix-on-droid";
    homeDirectory = "/data/data/com.termux.nix/files/home";

    sessionVariables.SSH_ASKPASS = pkgs.writers.writeDash "ssh_askpass" ''
      set -eu; ${config.programs.password-store.package}/bin/pass ssh/oppoReno8Z
    '';
  };
}
