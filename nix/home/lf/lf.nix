{ config, pkgs, lib, ... }:
let
	dateGoFmt = config.customVars.dateGoFmt;
in {
	config = {
		programs.lf = {
			settings = {
				autoquit = true;
				dircache = true;
				drawbox = true;
				globsearch = true;
				hidden = true;
				icons = true;
				incfilter = true;
				infotimefmtnew = "${dateGoFmt}";
				infotimefmtold = "${dateGoFmt}";
				number = true;
				promptfmt = ''[%u@%h %d%f]$'';
				relativenumber = true;
				shell = "${pkgs.dash}/bin/dash";
				shellopts = "-eu";
				sixel = true;
				tabstop = 4;
				wrapscroll = true;
			};
		};
	};
}
