{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.stylix = {
    enable = lib.mkEnableOption "whether to enable stylix with dummy options for nix-on-droid";
    base16Scheme = lib.mkOption { type = lib.types.path; };
    image = lib.mkOption { type = with lib.types; coercedTo package toString path; };

    polarity = lib.mkOption {
      type = lib.types.enum [
        "either"
        "light"
        "dark"
      ];
    };

    cursor = {
      name = lib.mkOption { type = lib.types.str; };
      package = lib.mkOption { type = lib.types.package; };
      size = lib.mkOption { type = lib.types.int; };
    };

    fonts =
      let
        fontType = lib.types.submodule {
          options = {
            package = lib.mkOption { type = lib.types.package; };
            name = lib.mkOption { type = lib.types.str; };
          };
        };
      in
      {
        serif = lib.mkOption { type = fontType; };
        sansSerif = lib.mkOption { type = fontType; };
        monospace = lib.mkOption { type = fontType; };
        emoji = lib.mkOption { type = fontType; };

        sizes = {
          applications = lib.mkOption { type = lib.types.ints.unsigned; };
          desktop = lib.mkOption { type = lib.types.ints.unsigned; };
          popups = lib.mkOption { type = lib.types.ints.unsigned; };
          terminal = lib.mkOption { type = lib.types.ints.unsigned; };
        };
      };

    opacity = {
      applications = lib.mkOption { type = lib.types.float; };
      desktop = lib.mkOption { type = lib.types.float; };
      popups = lib.mkOption { type = lib.types.float; };
      terminal = lib.mkOption { type = lib.types.float; };
    };
  };

  config.terminal =
    let
      colors =
        builtins.mapAttrs (name: value: "#${value}")
          (builtins.fromJSON (
            builtins.readFile (
              pkgs.runCommand "fromYAML" { }
                "${pkgs.remarshal}/bin/yaml2json \"${config.stylix.base16Scheme}\" \"$out\""
            )
          )).palette;
    in
    lib.mkIf config.stylix.enable {
      colors = {
        background = colors.base00;
        foreground = colors.base05;
        cursor = colors.base05;
        color0 = colors.base00;
        color1 = colors.base08;
        color2 = colors.base0B;
        color3 = colors.base0A;
        color4 = colors.base0D;
        color5 = colors.base0E;
        color6 = colors.base0C;
        color7 = colors.base05;
        color8 = colors.base03;
        color9 = colors.base08;
        color10 = colors.base0B;
        color11 = colors.base0A;
        color12 = colors.base0D;
        color13 = colors.base0E;
        color14 = colors.base0C;
        color15 = colors.base07;
      };
    };
}
