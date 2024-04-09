{ config, ... }:
{
	xdg.configFile."npm/npmrc" = {
		enable = true;

		text = ''
			cache="${config.xdg.cacheHome}/npm"
			prefix="${config.xdg.dataHome}/npm"
		'';
	};
}
