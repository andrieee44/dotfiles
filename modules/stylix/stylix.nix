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
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-emoji;
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
        opacity = 0.9;
      in
      {
        applications = opacity;
        desktop = opacity;
        popups = 1.0;
        terminal = opacity;
      };
  };
}
