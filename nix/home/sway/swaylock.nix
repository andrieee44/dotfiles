{ config, ... }:
let
	ringColor="#3b4252";
	keyColor = "#88c0d0";
	warnColor = "#d08770";
	verColor = "#a3be8c";
	errorColor = "#BF616A";
in
{
	config.programs.swaylock = {
		settings = {
			daemonize = true;
			show-failed-attempts = true;
			ignore-empty-password = true;
			scaling = "stretch";
			image = "${./../wallpapers/astronaut.png}";
			bs-hl-color = warnColor;
			text-color = keyColor;
			text-clear-color = warnColor;
			text-ver-color = verColor;
			text-wrong-color = errorColor;
			inside-color = ringColor;
			inside-clear-color = ringColor;
			inside-ver-color = ringColor;
			inside-wrong-color = ringColor;
			key-hl-color = keyColor;
			ring-color = ringColor;
			ring-clear-color = warnColor;
			ring-ver-color = verColor;
			ring-wrong-color = errorColor;
			line-color = keyColor;
			line-clear-color = keyColor;
			line-ver-color = keyColor;
			line-wrong-color = keyColor;
			separator-color = "#00000000";
			indicator-radius = 100;
			indicator-thickness = 20;
			font = config.gtk.font.name;
			font-size = 30;
		};
	};
}
