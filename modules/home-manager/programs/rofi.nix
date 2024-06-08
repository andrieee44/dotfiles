{ config, ... }:
{
	programs.rofi = {
		cycle = true;

		extraConfig = {
			matching = "fuzzy";
			terminal = config.home.sessionVariables.TERMINAL;
		};
	};
}
