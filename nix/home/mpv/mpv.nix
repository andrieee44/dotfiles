{ config, ... }:
{
	config.programs.mpv = {
		bindings = {
			h = "seek -5";
			j = "seek -60";
			k = "seek 60";
			l = "seek 5";
		};
	};
}
