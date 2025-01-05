{ config, lib, ... }:
{
  options.stylix.targets.custom.hyprlock = {
    enable = lib.mkEnableOption "custom implementation of styling hyprlock";

    radius = lib.mkOption {
      description = "input-field radius for hyprlock";
      type = lib.types.int;
      default = 5;
    };
  };

  config.programs.hyprlock.settings =
    let
      cfg = config.stylix.targets.custom.hyprlock;
      fonts = config.stylix.fonts;
      colors = config.lib.stylix.colors;
    in
    lib.mkIf cfg.enable {
      input-field = {
        font_family = fonts.monospace.name;
        size = "650, 90";
        fade_on_empty = false;
        placeholder_text = "Enter Password...";
        fail_text = "$FAIL";
        outer_color = "rgb(${colors.base03})";
        inner_color = "rgb(${colors.base00})";
        font_color = "rgb(${colors.base05})";
        fail_color = "rgb(${colors.base08})";
        check_color = "rgb(${colors.base0A})";
        outline_thickness = cfg.radius;
      };

      background = {
        path = "screenshot";
        blur_size = 8;
        blur_passes = 2;
      };

      label =
        let
          fontSize = fonts.sizes.applications;

          mkLabel =
            label:
            label
            // {
              font_family = fonts.monospace.name;
              color = "rgb(${colors.base05})";
              halign = "center";
              valign = "center";
            };
        in
        [
          (mkLabel {
            text = "cmd[update:60000] date '+%l:%M %p'";
            position = "0, 25%";
            font_size = fontSize * 4;
          })

          (mkLabel {
            text = "cmd[update:60000] date '+%A'";
            position = "0, 18%";
            font_size = fontSize * 3;
          })
        ];
    };
}
