{ config, ... }:
{
	config = {
		accounts.email.accounts."${config.customVars.user}".notmuch = {
			enable = config.programs.notmuch.enable;
		};
	};
}
