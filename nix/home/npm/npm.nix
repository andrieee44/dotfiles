{ config, ... }:
{
	config.home.file.npmrc = {
		executable = false;
		target = "${config.xdg.configHome}/npm/npmrc";

		text = ''
			cache="${config.xdg.cacheHome}/npm"
			prefix="${config.xdg.dataHome}/npm"
		'';
	};
}
