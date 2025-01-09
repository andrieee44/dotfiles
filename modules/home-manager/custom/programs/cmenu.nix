{
  config,
  pkgs,
  lib,
  ...
}:
{
  custom.programs.cmenu.package = pkgs.buildGoModule {
    name = "cmenu";
    vendorHash = null;

    src = pkgs.fetchFromGitHub {
      owner = "andrieee44";
      repo = "cmenu";
      rev = "b6faeef19ef55b95bc88795ac3774bf450d263be";
      hash = "sha256-n87EL+KCzazANeqhfRPIsGVQdRFTv0EN8miflV1eOUs=";
    };
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
