{ config, pkgs, lib, ... }:
{
	options.customVars.programs.moar = {
		enable = lib.mkEnableOption "";
		pager = lib.mkEnableOption "";
		style = config.customVars.mkOption lib.types.str;
	};

	config = let
		cfg = config.customVars.programs.moar;
	in {
		home = lib.mkIf cfg.enable {
			packages = [ pkgs.moar ];
			sessionVariables = {
				PAGER = lib.mkIf cfg.pager "${pkgs.moar}/bin/moar";
				MOAR = "--style ${cfg.style}";
			};
		};

		customVars.programs.moar = {
			enable = true;
			pager = true;
			style = let
				colorscheme = config.customVars.colorscheme;
			in if colorscheme == "default" then "native" else colorscheme;
		};
	};
}
