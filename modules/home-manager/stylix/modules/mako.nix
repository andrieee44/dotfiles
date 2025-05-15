{ config, lib, ... }:
{
  options.stylix.targets.custom.mako.enable =
    lib.mkEnableOption "custom implementation of styling mako";

  config.services.mako.settings =
    let
      colors = config.lib.stylix.colors.withHashtag;
      fonts = config.stylix.fonts;
      makoOpacity = lib.toHexString (((builtins.ceil (config.stylix.opacity.popups * 100)) * 255) / 100);
      cfg = config.stylix.targets.custom.mako;
    in
    lib.mkIf (config.services.mako.enable && cfg.enable) {
      background-color = colors.base00 + makoOpacity;
      border-color = colors.base0D;
      font = "${fonts.sansSerif.name} ${builtins.toString fonts.sizes.popups}";
      progress-color = "over ${colors.base02}";
      text-color = colors.base05;

      "urgency=low" = {
        background-color = "${colors.base00}${makoOpacity}";
        border-color = colors.base0D;
        text-color = colors.base0A;
      };

      "urgency=high" = {
        background-color = "${colors.base00}${makoOpacity}";
        border-color = colors.base0D;
        text-color = colors.base08;
      };
    };
}
