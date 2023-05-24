{ config, ... }:
{
	config.programs.mangohud = {
		enableSessionWide = true;
		settings = {
			fps_limit = 60;
		};
	};
}
