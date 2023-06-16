{ config, ... }:
{
	config.xdg.configFile.npmrc = {
		target = "npm/npmrc";

		text = ''
			cache="${config.xdg.cacheHome}/npm"
			prefix="${config.xdg.dataHome}/npm"
		'';
	};
}
