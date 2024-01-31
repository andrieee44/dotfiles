{ config, pkgs, lib, ... }:
{
	options.customVars.programs.moar = let
		mkEnableOption = config.customVars.mkOption lib.types.bool;
	in {
		enable = mkEnableOption;
		pager = mkEnableOption;
		style = config.customVars.mkOption lib.types.str;
	};

	config = let
		cfg = config.customVars.programs.moar;
	in {
		customVars.programs.moar = {
			enable = true;
			pager = true;
			style = let
				colorscheme = config.customVars.colorscheme;
			in if colorscheme == "default" then "native" else colorscheme;
		};

		home = lib.mkIf cfg.enable {
			packages = [ pkgs.moar ];
			sessionVariables = {
				PAGER = lib.mkIf cfg.pager "${pkgs.moar}/bin/moar";
				MOAR = "--style ${cfg.style}";
			};
		};
	};
}
