{ config, ... }:
{
	config.programs.git = {
		userEmail = config.accounts.email.accounts."${config.home.username}".address;
		userName = config.home.username;
	};
}
