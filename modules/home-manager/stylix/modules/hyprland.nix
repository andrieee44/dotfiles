{ config, pkgs, lib, ... }:
{
	options.stylix.targets.custom.hyprland.enable = lib.mkEnableOption "custom implementation of styling hyprland";
	config.wayland.windowManager.hyprland.settings.exec-once = lib.mkIf config.stylix.targets.custom.hyprland.enable [ "${pkgs.swaybg}/bin/swaybg -m fill -i ${config.stylix.image}" ];
}
