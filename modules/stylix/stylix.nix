{ pkgs, ... }:
{
	stylix = {
		enable = true;
		image = ./wallpaper;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
		polarity = "dark";

		cursor = {
			package = pkgs.vanilla-dmz;
			name = "Vanilla-DMZ";
			size = 32;
		};

		fonts = let
			monospace = {
				package = pkgs.nerdfonts.override { fonts = [ "SourceCodePro" ]; };
				name = "SauceCodePro Nerd Font Mono";
			};
		in {
			serif = monospace;
			sansSerif = monospace;
			monospace = monospace;

			emoji = {
				package = pkgs.noto-fonts-emoji;
				name = "Noto Color Emoji";
			};

			sizes = let
				size = 14;
			in {
				applications = size;
				desktop = size;
				popups = size;
				terminal = size;
			};
		};

		opacity = let
			opacity = 0.9;
		in {
			applications = opacity;
			desktop = opacity;
			popups = 1.0;
			terminal = opacity;
		};
	};
}
