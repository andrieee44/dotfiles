{ config, ... }:
{
	programs.git = {
		userName = config.home.username;
		extraConfig.color.pager = false;
	};
}
