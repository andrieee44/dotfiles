{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs = {
    toml-sort.enable = true;

    nixfmt = {
      enable = true;
      package = pkgs.nixfmt-rfc-style;
    };
  };

  settings = {
    formatter.nixfmt.options = [ "-s" ];

    global.excludes = [
      "LICENSE"
      "flake.lock"
      "modules/home-manager/custom/programs/eww/eww.yuck"
      "modules/home-manager/programs/aerc/gui.conf"
      "modules/home-manager/programs/lf/guiIcons"
      "modules/home-manager/programs/lf/ttyIcons"
      "modules/home-manager/xdg/bc/bcrc"
      "modules/stylix/wallpaper"
      "*.opus"
      "*.key"
    ];
  };
}
