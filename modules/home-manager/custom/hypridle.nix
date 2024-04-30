{ config, pkgs, lib, ... }:
let
	cfg = config.services.hypridle;
in {
	options.services.hypridle = {
		enable = lib.mkEnableOption "hypridle";
		settings = lib.mkOption { type = lib.types.lines; };
	};

	config = lib.mkIf cfg.enable {
		home.packages = [ pkgs.hypridle ];
		xdg.configFile."hypr/hypridle.conf".text = cfg.settings;
	};
}
