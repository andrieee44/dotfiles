{ config, lib, ... }:
{
	options.stylix.targets.custom.eww.enable = lib.mkEnableOption "custom implementation of styling eww";

	config.custom.programs.eww.scss = let
		colors = config.lib.stylix.colors.withHashtag;
	in lib.mkIf config.stylix.targets.custom.eww.enable ''
		label { color: ${colors.base05} }
		.sep { color: ${colors.base0D} }
		.icon { color: ${colors.base0C} }

		.activeWorkspace {
			color: ${colors.base0C};
			background-color: ${colors.base03};
		}
	'';
}
