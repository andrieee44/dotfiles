{ config, ... }:
{
	services.mbsync = {
		enable = config.programs.mbsync.enable;
		frequency = "1h";
	};
}
