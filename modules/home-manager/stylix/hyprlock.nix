{ config, lib, ... }:
{
	options.stylix.targets.custom.hyprlock.enable = lib.mkEnableOption "custom implementation of styling hyprlock";

	config.programs.hyprlock.settings = lib.mkIf config.stylix.targets.custom.hyprlock.enable {
		background = [ { path = "${config.stylix.image}"; } ];
	};
}
