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
      in
      {
        aerc.enable = true;
        fzf.enable = true;
        imv.enable = true;
        lf.enable = true;
        mpv.enable = true;
        ncmpcpp.enable = true;
        tmux.enable = true;
        zathura.enable = true;
        zsh.enable = true;

        eww = {
          enable = true;

          border = {
            radius = hyprlandSettings.decoration.rounding;
            width = hyprlandSettings.general.border_size;
            color = config.lib.stylix.colors.withHashtag.base0D;
          };
        };

        hyprlock = {
          enable = true;
          radius = hyprlandSettings.decoration.rounding;
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
          background_alpha = 0.5;
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
