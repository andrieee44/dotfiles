{ config, pkgs, lib, ... }:
let
	toml = (pkgs.formats.toml {});
in {
	options.custom.programs.jsonstatus = {
		enable = lib.mkEnableOption "jsonstatus";
		settings = lib.mkOption { type = lib.types.attrsOf toml.type; };
		package = lib.mkOption { type = lib.types.package; };
	};

	config = let
		cfg = config.custom.programs.jsonstatus;
	in {
		home.packages = [ cfg.package ];
		xdg.configFile."jsonstatus/jsonstatus.toml".source = lib.mkIf cfg.enable (toml.generate "jsonstatus.toml" cfg.settings);
	};
}
