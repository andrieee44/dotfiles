{ config, lib, pkgs, ... }:
{
	options.customVars.programs.mpv = let
		mkEnableOption = config.customVars.mkOption lib.types.bool;
	in {
		uosc = mkEnableOption;
		thumbfast = mkEnableOption;
	};

	config = let
		cfg = config.customVars.programs.mpv;
	in {
		customVars.programs.mpv = {
			uosc = true;
			thumbfast = true;
		};

		programs.mpv = {
			scripts = with pkgs.mpvScripts; [
				(lib.mkIf cfg.uosc uosc)
				(lib.mkIf cfg.thumbfast thumbfast)
			];

			scriptOpts = {
				thumbfast.network = true;
			};

			config = {
				osd-bar = !cfg.uosc;
				border = !cfg.uosc;
			};
		};
	};
}
