{ config, ... }:
{
	config = {
		services.mbsync = {
			enable = config.programs.mbsync.enable;
			frequency = "1h";
		};

		accounts.email.accounts."${config.customVars.user}".mbsync = {
			enable = config.programs.mbsync.enable;
			create = "both";
		};
	};
}
