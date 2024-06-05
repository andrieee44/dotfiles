{ config, lib, ... }:
{
	options.stylix.targets.custom.console.enable = lib.mkEnableOption "custom implementation of styling console";

	config.console.colors = let
		colors = config.lib.stylix.colors;
	in lib.mkIf config.stylix.targets.custom.console.enable [
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
