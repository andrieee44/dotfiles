{ config, lib, ... }:
{
	options.customVars.programs.waybar = let
		colorOption = config.customVars.mkOption (lib.types.strMatching "#[[:xdigit:]]{6}");
	in {
		separatorColor = colorOption;
		color = colorOption;
	};
}
