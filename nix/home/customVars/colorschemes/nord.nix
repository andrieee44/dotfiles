{ config, lib, ... }:
let
	colorscheme = config.customVars.colorschemes.nord;
in {
	config.programs = lib.mkIf (config.customVars.colorscheme == "nord") {
		alacritty.settings.colors = {
			primary = {
				background = "#2e3440";
				foreground = "#d8dee9";
				dim_foreground = "#a5abb6";
			};

			cursor = {
				text = "#2e3440";
				cursor = "#d8dee9";
			};

			vi_mode_cursor = {
				text = "#2e3440";
				cursor = "#d8dee9";
			};

			selection = {
				text = "CellForeground";
				background = "#4c566a";
			};

			search = {
				matches = {
					foreground = "CellBackground";
					background = "#88c0d0";
				};
			};

			footer = {
				bar = {
					background = "#434c5e";
					foreground = "#d8dee9";
				};
			};

			dim = {
				black = "#373e4d";
				red = "#94545d";
				green = "#809575";
				yellow = "#b29e75";
				blue = "#68809a";
				magenta = "#8c738c";
				cyan = "#6d96a5";
				white = "#aeb3bb";
			};

			normal = colorscheme.normal;
			bright = colorscheme.bright;
		};
	};
}
