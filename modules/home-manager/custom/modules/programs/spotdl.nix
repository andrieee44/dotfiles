{ config, pkgs, lib, ... }:
{
	options.custom.programs.spotdl = {
		enable = lib.mkEnableOption "spotdl";
		settings = lib.mkOption { type = lib.types.attrsOf (pkgs.formats.json {}).type; };
	};

	config = let
		cfg = config.custom.programs.spotdl;
	in lib.mkIf cfg.enable {
		home = {
			file.".spotdl/config.json".text = builtins.toJSON cfg.settings;
			packages = [ pkgs.spotdl ];
		};
	};
}
