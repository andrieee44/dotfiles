{ config, lib, ... }:
{
	options.custom.programs.cmenu = {
		enable = lib.mkEnableOption "cmenu";
		package = lib.mkOption { type = lib.types.package; };
	};

	config.home.packages = let
		cfg = config.custom.programs.cmenu;
	in [ cfg.package ];
}
