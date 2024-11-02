{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.custom.programs.eww = {
    enable = lib.mkEnableOption "eww";

    yuck = lib.mkOption {
      description = "eww.yuck";
      type = lib.types.lines;
    };

    scss = lib.mkOption {
      description = "eww.scss";
      type = lib.types.lines;
    };
  };

  config =
    let
      cfg = config.custom.programs.eww;
    in
    lib.mkIf cfg.enable {
      home.packages = [ pkgs.eww ];

      xdg.configFile = {
        "eww/eww.yuck".text = cfg.yuck;
        "eww/eww.scss".text = cfg.scss;
      };
    };
}
