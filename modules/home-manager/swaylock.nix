{ config, ... }:
{
	programs.swaylock = {
		settings = {
			daemonize = true;
			show-failed-attempts = true;
			ignore-empty-password = true;
			scaling = "stretch";
			indicator-radius = 100;
			indicator-thickness = 20;
			font = config.gtk.font.name;
			font-size = config.gtk.font.size * 2;
		};
	};
}
