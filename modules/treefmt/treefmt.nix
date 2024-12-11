{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs = {
    nixfmt = {
      enable = true;
      package = pkgs.nixfmt-rfc-style;
    };
  };

  settings = {
    global.excludes = [
      "LICENSE"
      "flake.lock"
      "modules/home-manager/programs/lf/guiIcons"
      "modules/home-manager/programs/lf/ttyIcons"
      "modules/home-manager/xdg/bc/bcrc"
      "modules/stylix/wallpaper"
      "*.opus"
      "*.pub"
    ];

    formatter = {
      nixfmt.options = [ "-s" ];
    };
  };
}
