{ config, pkgs, lib, ... }:
{
	config = lib.mkIf (config.customVars.font == "saucecodepro") {
		fonts = {
			packages = [
				(pkgs.nerdfonts.override {
					fonts = [
						"SourceCodePro"
					];
				})
			];

			fontconfig.defaultFonts = {
				emoji = [
					"SauceCodePro Nerd Font"
				];

				serif = [
					"SauceCodePro Nerd Font"
				];

				sansSerif = [
					"SauceCodePro Nerd Font"
				];

				monospace = [
					"SauceCodePro Nerd Font Mono"
				];
			};
		};
	};
}
