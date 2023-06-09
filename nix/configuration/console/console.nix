{ config, pkgs, ... }:
{
	config.console = {
		useXkbConfig = true;
		font = "${pkgs.terminus_font}/share/consolefonts/ter-122b.psf.gz";

		colors = let
			colorschemes = {
				nord = [
					"3b4252"
					"bf616a"
					"a3be8c"
					"ebcb8b"
					"81a1c1"
					"b48ead"
					"88c0d0"
					"e5e9f0"
					"4c566a"
					"bf616a"
					"a3be8c"
					"ebcb8b"
					"81a1c1"
					"b48ead"
					"8fbcbb"
					"eceff4"
				];
			};
		in colorschemes.${config.customVars.colorscheme};
	};
}
