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
				uosc = {
					timeline_style = "bar";
					timeline_size_min = 10;
					timeline_size_min_fullscreen = 10;
					timeline_opacity = 1;
				};

				thumbfast.network = true;
			};

			config = {
				osd-bar = !cfg.uosc;
				border = !cfg.uosc;
				video-sync = lib.mkIf cfg.uosc "display-resample";
			};
		};
	};
}
