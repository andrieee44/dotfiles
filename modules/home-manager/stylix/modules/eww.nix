{ config, lib, ... }:
{
  options.stylix.targets.custom.eww = {
    enable = lib.mkEnableOption "custom implementation of styling eww";

    border = {
      radius = lib.mkOption {
        description = "border radius for eww";
        type = lib.types.int;
        default = 5;
      };

      width = lib.mkOption {
        description = "border size for eww";
        type = lib.types.int;
        default = 5;
      };

      color = lib.mkOption {
        description = "border color for eww";
        type = lib.types.strMatching "#[[:xdigit:]]{6}";
        default = "#FFFFFF";
      };
    };
  };

  config.custom.programs.eww.scss =
    let
      cfg = config.stylix.targets.custom.eww;
      colors = config.lib.stylix.colors.withHashtag;
      noHashColors = config.lib.stylix.colors;
    in
    lib.mkIf cfg.enable ''
      label { color: ${colors.base05}; }
      .sep { color: ${colors.base0D}; }
      .icon { color: ${colors.base0C}; }

      .bar {
      	border-radius: ${builtins.toString (cfg.border.radius + cfg.border.width)}px;
      	border: ${builtins.toString cfg.border.width}px solid ${cfg.border.color};
      	background-color: rgba(${noHashColors.base00-rgb-r}, ${noHashColors.base00-rgb-g}, ${noHashColors.base00-rgb-b}, ${builtins.toString config.stylix.opacity.popups});
      }

      .activeWorkspace {
      	border-radius: ${builtins.toString (cfg.border.radius)}px;
      	background-color: ${colors.base03};
      	color: ${colors.base0C};
      }

      button {
      	font-weight: normal;
      	background-color: transparent;
      }
    '';
}
