{ config, ... }:
{
	programs.git = {
		userName = config.home.username;

		signing = {
			key = null;
			signByDefault = true;
		};
	};
}
