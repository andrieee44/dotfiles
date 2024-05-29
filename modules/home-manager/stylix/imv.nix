{ config, lib, ... }:
{
	options.stylix.targets.custom.imv.enable = lib.mkEnableOption "custom implementation of styling imv";

	config.programs.imv.settings.options = let
		colors = config.lib.stylix.colors.withHashtag;
	in lib.mkIf config.stylix.targets.custom.imv.enable {
		overlay_text_color = colors.base05;
		overlay_background_color = colors.base02;
		background = colors.base01;
	};
}
