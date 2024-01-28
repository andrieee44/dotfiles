{ config, lib, ... }:
let
	customVars = config.customVars;
in {
	options.customVars.programs.waybar = let
		colorOption = customVars.mkOption (lib.types.strMatching "#[[:xdigit:]]{6}");
	in {
		separatorColor = colorOption;
		color = colorOption;
	};
}
