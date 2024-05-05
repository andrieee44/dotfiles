{ config, pkgs, lib, ... }:
{
	options.programs.spotdl = {
		enable = lib.mkEnableOption "spotdl";
		settings = lib.mkOption { type = lib.types.attrsOf (pkgs.formats.json {}).type; };
	};

	config = let
		cfg = config.programs.spotdl;
	in lib.mkIf cfg.enable {
		home = {
			file.".spotdl/config.json".text = builtins.toJSON cfg.settings;
			packages = [ pkgs.spotdl ];
		};
	};
}
