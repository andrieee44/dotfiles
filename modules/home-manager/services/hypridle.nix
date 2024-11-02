{ config, pkgs, ... }:
{
  services.hypridle.settings = {
    general = {
      lock_cmd = "${pkgs.toybox}/bin/pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock --immediate";
      before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session";
      after_sleep_cmd = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
    };

    listener = [
      {
        timeout = 60;
        on-timeout = "${pkgs.light}/bin/light -O && ${pkgs.light}/bin/light -S 5";
        on-resume = "${pkgs.light}/bin/light -I";
      }

      {
        timeout = 120;
        on-timeout = "${pkgs.systemd}/bin/loginctl lock-session";
      }

      {
        timeout = 300;
        on-timeout = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        on-resume = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }

      {
        timeout = 600;
        on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
}
