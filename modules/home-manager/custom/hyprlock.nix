{ config, pkgs, lib, ... }:
let
	cfg = config.programs.hyprlock;
in {
	options.programs.hyprlock = {
		enable = lib.mkEnableOption "hyprlock";
		settings = lib.mkOption { type = lib.types.lines; };
	};

	config = lib.mkIf cfg.enable {
		home.packages = [ pkgs.hyprlock ];
		xdg.configFile."hypr/hyprlock.conf".text = cfg.settings;
	};
}
