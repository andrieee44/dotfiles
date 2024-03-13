{ pkgs, ... }:
{
	programs.lf = {
		settings = let
			dateGoFmt = "Jan _2 2006 (Mon) _3:04 PM";
		in {
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
			relativenumber = true;
			shell = "${pkgs.dash}/bin/dash";
			shellopts = "-eu";
			sixel = true;
			tabstop = 4;
			wrapscroll = true;
		};
	};
}
