{ config, lib, ... }:
{
  options.stylix.targets.custom.mpv.enable =
    lib.mkEnableOption "custom implementation of styling mpv";

  config.programs.mpv.scriptOpts.uosc.color =
    let
      colors = config.lib.stylix.colors;
    in
    lib.mkIf (config.programs.mpv.enable && config.stylix.targets.custom.mpv.enable)
      "foreground=${colors.base05},foreground_text=${colors.base01},background=${colors.base02},background_text=${colors.base05},curtain=${colors.base03},success=${colors.base0B},error=${colors.base08}";
}
