{ config, pkgs, lib, ... }:
{
	config = let
		customVars = config.customVars;

		colorscheme = customVars.colorschemes.nord;
		normal = colorscheme.normal;
		bright = colorscheme.bright;
	in lib.mkIf (customVars.colorscheme == "default") {
		customVars.waybar = {
			separatorColor = normal.white;
			color = normal.cyan;
		};

		gtk = {
			cursorTheme = {
				package = pkgs.vanilla-dmz;
				name = "Vanilla-DMZ";
			};

			iconTheme = {
				package = pkgs.gnome.adwaita-icon-theme;
				name = "Adwaita-dark";
			};

			theme = {
				package = pkgs.gnome.gnome-themes-extra;
				name = "Adwaita-dark";
			};
		};
	};
}
