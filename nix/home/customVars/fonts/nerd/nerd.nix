{ config, lib, ... }:
{
	options.customVars.fonts.nerdFont = config.customVars.mkOption lib.types.bool;

	config.xdg.configFile.lficons = {
		enable = config.programs.lf.enable;
		target = "lf/icons";
		source = ./lficons;
	};
}
