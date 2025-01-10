{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland.enable = true;

  custom.programs = {
    jstat.enable = true;
    eww.enable = true;
  };

  home = {
    shellAliases.idleGames = "steam steam://rungameid/346900 && steam steam://rungameid/2763740 && steam steam://rungameid/1399720";

    packages = with pkgs; [
      glxinfo
      grim
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-lgc-plus
      noto-fonts-monochrome-emoji
      vistafonts
      vistafonts
      wl-clipboard
    ];

    sessionVariables = {
      BROWSER = "${config.programs.firefox.finalPackage}/bin/firefox-esr";
      TERMINAL = "${config.programs.foot.package}/bin/footclient";
    };
  };

  programs = {
    firefox.enable = true;
    foot.enable = true;
    hyprlock.enable = true;
    imv.enable = true;
    mangohud.enable = true;
    mpv.enable = true;
    obs-studio.enable = true;
    zathura.enable = true;
  };

  services = {
    hypridle.enable = true;
    hyprpaper.enable = true;
    mako.enable = true;
  };

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  xdg = {
    mime.enable = true;
    mimeApps.enable = true;

    portal = {
      enable = true;
      config.common.default = "*";
    };
  };
}
