{ config, ... }:
{
  stylix.targets = {
    firefox.profileNames = [ "default" ];
    fzf.enable = false;
    hyprlock.enable = false;
    tmux.enable = false;

    custom =
      let
        hyprlandSettings = config.wayland.windowManager.hyprland.settings;
        radius = hyprlandSettings.decoration.rounding;
      in
      {
        aerc.enable = true;
        fzf.enable = true;
        imv.enable = true;
        lf.enable = true;
        ncmpcpp.enable = true;
        tmux.enable = true;
        zathura.enable = true;
        zsh.enable = true;

        eww = {
          enable = true;

          border = {
            color = config.lib.stylix.colors.withHashtag.base0D;
            radius = radius;
            width = hyprlandSettings.general.border_size;
          };
        };

        hyprlock = {
          enable = true;
          radius = radius;
        };

        nixvim = {
          enable = true;

          transparentBackground = {
            lineNumbers = true;
            otherWindows = true;
          };
        };

        mangohud = {
          enable = true;
          radius = radius;
        };
      };

    nixvim = {
      plugin = "base16-nvim";

      transparentBackground = {
        main = true;
        signColumn = true;
      };
    };
  };

  fonts.fontconfig.defaultFonts =
    let
      fonts = config.stylix.fonts;
    in
    {
      monospace = [ fonts.monospace.name ];
      serif = [ fonts.serif.name ];
      sansSerif = [ fonts.sansSerif.name ];
      emoji = [ fonts.emoji.name ];
    };
}
