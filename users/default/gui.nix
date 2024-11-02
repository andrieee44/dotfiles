{ config, pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  wayland.windowManager.hyprland.enable = true;
  custom.programs.eww.enable = true;

  home = {
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
    mako.enable = true;
  };

  gtk = {
    enable = true;
    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };

  xdg = {
    mimeApps.associations.added =
      let
        text = [
          "nvim.desktop"
          "nvimGUI.desktop"
        ];
      in
      {
        "text/x-bibtex" = text;
      };

    portal = {
      enable = true;
      config.common.default = "*";
    };
  };

  systemd.user.services = {
    afk.Service = {
      Type = "exec";

      ExecStart = pkgs.writers.writeDash "afkservice" ''
        set -eu

        while ${pkgs.toybox}/bin/true; do
        	${pkgs.wtype}/bin/wtype "               "
        	${pkgs.toybox}/bin/sleep 300
        done
      '';
    };
  };
}
