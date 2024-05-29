{ config, lib, ... }:
{
	options.stylix.targets.console.custom.enable = lib.mkEnableOption "custom implementation of stylix.targets.console";

	config.console.colors = let
		colors = config.lib.stylix.colors;
	in lib.mkIf config.stylix.targets.console.custom.enable [
		colors.base00
		colors.base08
		colors.base0B
		colors.base0A
		colors.base0D
		colors.base0E
		colors.base0C
		colors.base05
		colors.base03
		colors.base08
		colors.base0B
		colors.base0A
		colors.base0D
		colors.base0E
		colors.base0C
		colors.base07
	];
}
