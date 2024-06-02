{ config, lib, ... }:
{
	options.stylix.targets.custom.rofi.enable = lib.mkEnableOption "custom implementation of styling rofi";
	config.wayland.windowManager.hyprland.settings.windowrule = lib.mkIf config.stylix.targets.custom.rofi.enable [ "float,^(Rofi)$" ];
}
