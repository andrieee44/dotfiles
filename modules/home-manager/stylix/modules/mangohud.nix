{ config, lib, ... }:
{
  options.stylix.targets.custom.mangohud = {
    enable = lib.mkEnableOption "custom implementation of styling mangohud";

    radius = lib.mkOption {
      description = "border radius for mangohud";
      type = lib.types.int;
      default = 5;
    };
  };

  config.programs.mangohud.settings =
    let
      cfg = config.stylix.targets.custom.mangohud;
    in
    lib.mkIf (config.programs.mangohud.enable && cfg.enable) {
      battery_icon = "󰁹";
      cellpadding_y = 0;
      device_battery_icon = "󰂯";
      font_file_text = config.stylix.fonts.monospace.name;
      fps_color_change = true;
      height = 0;
      hud_compact = true;
      hud_no_margin = false;
      no_small_font = true;
      position = "top-center";
      round_corners = cfg.radius;
      table_columns = 3;
      width = 0;
    };
}
