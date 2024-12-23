{ config, lib, ... }:
{
  systemd.user.services.hyprpaper.Unit.After = lib.mkIf config.services.hyprpaper.enable [
    "graphical-session.target"
  ];
}
