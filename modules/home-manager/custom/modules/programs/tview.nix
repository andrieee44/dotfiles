{ config, lib, ... }:
{
	options.custom.programs.tview = {
		enable = lib.mkEnableOption "tview";
		package = lib.mkOption { type = lib.types.package; };
	};

	config.home.packages = [ config.custom.programs.tview.package ];
}
