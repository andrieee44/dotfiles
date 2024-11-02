{ config, ... }:
{
  xdg.configFile."npm/npmrc".text = ''
    	cache="${config.xdg.cacheHome}/npm"
    	prefix="${config.xdg.dataHome}/npm"
  '';
}
