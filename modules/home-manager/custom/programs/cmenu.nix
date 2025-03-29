{
  config,
  pkgs,
  lib,
  ...
}:
{
  custom.programs.cmenu.package =
    let
      src = pkgs.fetchFromGitHub {
        owner = "andrieee44";
        repo = "cmenu";
        rev = "7a811eba36ede8ec128fb3e7836e879e4fac321e";
        hash = "sha256-rz0z93OMYglPEMdyTlJna5RYWXIDcSbOd81vEcirUWs=";
      };
    in
    pkgs.buildGoModule {
      inherit src;
      name = "cmenu";
      vendorHash = "sha256-p/WFrGNF7UTiRKxhSaZaI5HJTOAKv8MGDi47k3fBOK0=";

      postInstall = ''
        mkdir -p "${"\${out}"}/share/man/man1"
        gzip -c "${src}/cmenu.1" > "${"\${out}"}/share/man/man1/cmenu.1.gz"
      '';
    };

  xdg.dataFile = lib.mkIf config.custom.programs.cmenu.enable {
    "cmenu/bookmarks.json".text = builtins.toJSON {
      " YouTube " = "https://www.youtube.com/";
      " Messenger | Facebook 󰈌" = "https://www.facebook.com/messages/";
      "󰌌 Monkeytype | A minimalistic, customizable typing test 󰌌" = "https://monkeytype.com/";
      "󱄅 Noogle - Simply find Nix API reference documentation. 󰈙" = "https://noogle.dev/";
      "󱄅 NixOS Search - Packages 󰏔" = "https://search.nixos.org/packages?";
      "󱄅 NixOS Search - Options " = "https://search.nixos.org/options?";
      "󰖌 Hyprland Wiki " = "https://wiki.hyprland.org/";
      "󰊤 GitHub 󰊤" = "https://github.com/";
      "󰱫 Nerd Fonts - Iconic font aggregator, glyphs/icons collection, & fonts patcher 󰱫" =
        "https://www.nerdfonts.com/cheat-sheet";
      " Discord " = "https://discord.com/channels/@me";
      " Microsoft Copilot: Your AI companion " = "https://copilot.microsoft.com/";
    };

    "cmenu/system.json".text = builtins.toJSON {
      "󰐥 Power off 󰐥" = "${pkgs.systemd}/bin/poweroff";
      "󰜉 Reboot 󰜉" = "${pkgs.systemd}/bin/reboot";
      "󰌾 Lock 󰌾" = "${pkgs.systemd}/bin/loginctl lock-session";
      "󰤄 Sleep 󰤄" = "${pkgs.systemd}/bin/systemctl suspend";
      " Reload Hyprland " = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl reload";
      " Kill Hyprland " = "${pkgs.systemd}/bin/loginctl kill-user \"$(whoami)\"";
    };
  };
}
