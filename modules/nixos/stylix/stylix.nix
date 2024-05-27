{ config, lib, ... }:
{
	console.colors = let
		colors = config.lib.stylix.colors;
	in lib.mkForce [
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
