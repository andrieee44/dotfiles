{ config, lib, ... }:
{
	options.stylix.targets.custom.zathura.enable = lib.mkEnableOption "custom implementation of styling zathura";

	config.programs.zathura.options = let
		colors = config.lib.stylix.colors.withHashtag;
		fonts = config.stylix.fonts;
	in lib.mkIf config.stylix.targets.custom.zathura.enable {
		font = "${fonts.monospace.name} ${builtins.toString fonts.sizes.applications}";
		statusbar-fg = lib.mkForce colors.base07;
	};
}
