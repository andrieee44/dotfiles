{ config, ... }:
{
	config.xdg.configFile.npmrc = {
		enable = true;
		target = "npm/npmrc";

		text = ''
			cache="${config.xdg.cacheHome}/npm"
			prefix="${config.xdg.dataHome}/npm"
		'';
	};
}
