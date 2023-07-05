{ config, ... }:
{
	config = {
		services.mbsync = {
			enable = config.programs.mbsync.enable;
			frequency = "1h";
		};

		accounts.email.accounts."${config.home.username}".mbsync = {
			enable = config.programs.mbsync.enable;
			create = "both";
		};
	};
}
