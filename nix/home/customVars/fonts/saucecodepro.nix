{ config, pkgs, lib, ... }:
{
	config = lib.mkIf (config.customVars.font == "saucecodepro") {
		gtk.font = {
			package = pkgs.nerdfonts.override {
				fonts = [
					"SourceCodePro"
				];
			};

			name = "Sauce Code Pro Nerd Font Mono";
		};

		customVars.fonts.nerdFont = true;

		programs.mangohud.settings = {
			font_file = "${config.gtk.font.package}/share/fonts/truetype/NerdFonts/SauceCodeProNerdFont-Regular.ttf";
		};
	};
}
