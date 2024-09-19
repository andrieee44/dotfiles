{ config, pkgs, lib, ... }:
{
	options.custom.programs.tview = {
		enable = lib.mkEnableOption "tview";
		package = lib.mkOption { type = lib.types.package; };
		settings = lib.mkOption { type = lib.types.attrsOf (pkgs.formats.json {}).type; };
	};

	config = let
		cfg = config.custom.programs.tview;
	in lib.mkIf cfg.enable {
		home.packages = [ cfg.package ];
		xdg.configFile."tview/config.json".text = builtins.toJSON cfg.settings;
	};
}
