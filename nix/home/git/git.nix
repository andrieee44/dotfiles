{ config, ... }:
{
	config.programs.git = {
		userEmail = config.accounts.email.accounts."${config.customVars.user}".address;
		userName = config.customVars.user;
	};
}
