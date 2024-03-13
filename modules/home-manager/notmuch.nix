{ config, ... }:
{
	accounts.email.accounts."${config.home.username}".notmuch.enable = config.programs.notmuch.enable;
}
