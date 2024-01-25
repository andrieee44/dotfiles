{ config, pkgs, lib, ... }:
{
	config.console = {
		useXkbConfig = true;
		font = config.customVars.consoleFont;

		colors = let
			colorscheme = config.customVars.colorschemes."${config.customVars.colorscheme}";
			normal = colorscheme.normal;
			bright = colorscheme.bright;
			nohash = hex:
			lib.removePrefix "#" hex;
		in [
			"${nohash normal.black}"
			"${nohash normal.red}"
			"${nohash normal.green}"
			"${nohash normal.yellow}"
			"${nohash normal.blue}"
			"${nohash normal.magenta}"
			"${nohash normal.cyan}"
			"${nohash normal.white}"

			"${nohash bright.black}"
			"${nohash bright.red}"
			"${nohash bright.green}"
			"${nohash bright.yellow}"
			"${nohash bright.blue}"
			"${nohash bright.magenta}"
			"${nohash bright.cyan}"
			"${nohash bright.white}"
		];
	};
}
