{ config, lib, ... }:
{
	options.stylix.targets.custom.lf.enable = lib.mkEnableOption "custom implementation of styling lf";

	config.programs.lf.settings = lib.mkIf config.stylix.targets.custom.lf.enable {
		borderfmt = "\\033[0;34m";
		cursorparentfmt = "\\033[4m";
	};
}
