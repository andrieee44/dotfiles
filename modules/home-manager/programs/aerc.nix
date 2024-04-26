{ config, ... }:
{
	programs.aerc.extraConfig = {
		general.unsafe-accounts-conf = true;
		filters."text/plain" = "colorize";
		viewer.pager = config.home.sessionVariables.PAGER;
	};
}
