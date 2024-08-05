{ config, lib, ... }:
{
	options.custom.programs.jstat = {
		enable = lib.mkEnableOption "jstat";
		package = lib.mkOption { type = lib.types.package; };
	};

	config.home.packages = [ config.custom.programs.jstat.package ];
}
