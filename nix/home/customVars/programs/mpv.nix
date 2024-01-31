{ config, lib, pkgs, ... }:
{
	options.customVars.programs.mpv = let
		mkEnableOption = config.customVars.mkOption lib.types.bool;
	in {
		uosc = mkEnableOption;
	};

	config = let
		cfg = config.customVars.programs.mpv;
	in {
		customVars.programs.mpv = {
			uosc = true;
		};

		programs.mpv = {
			scripts = with pkgs.mpvScripts; [
				(lib.mkIf cfg.uosc uosc)
			];

			config = {
				osd-bar = !cfg.uosc;
				border = !cfg.uosc;
			};
		};
	};
}
