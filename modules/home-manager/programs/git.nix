{ config, ... }:
{
	programs.git = {
		userName = config.home.username;

		signing = {
			key = "A555AF06F5A80AB1";
			signByDefault = true;
		};
	};
}
