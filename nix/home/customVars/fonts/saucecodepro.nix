{ config, pkgs, lib, ... }:
{
	config = {
		gtk.font = config.customVars.fonts.nerdFontMk {
		package = pkgs.nerdfonts.override {
			fonts = [
				"SourceCodePro"
			];
		};

		name = "Sauce Code Pro Nerd Font Mono";
	};

	customVars.fonts.nerdFontBool = true;
	};
}
