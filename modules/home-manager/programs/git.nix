{ config, ... }:
{
	programs.git.userName = config.home.username;
}
