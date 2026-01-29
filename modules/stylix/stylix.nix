{ config, pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ./wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";

    cursor = {
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ";
      size = 32;
    };

    fonts =
      let
        monospace = config.stylix.fonts.monospace;
      in
      {
        monospace = {
          package = pkgs.nerd-fonts.sauce-code-pro;
          name = "SauceCodePro Nerd Font Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };

        sizes =
          let
            size = 14;
          in
          {
            applications = size;
            desktop = size;
            popups = size;
            terminal = size;
          };

        serif = monospace;
        sansSerif = monospace;
      };

    opacity =
      let
        opacity = 0.8;
      in
      {
        applications = opacity;
        desktop = opacity;
        popups = opacity;
        terminal = opacity;
      };
  };
}
