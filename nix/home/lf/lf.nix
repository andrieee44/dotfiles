{ config, pkgs, ... }:
{
	config.programs.lf = let
		ctpv = "${pkgs.ctpv}/bin";
	in {
		settings = let
			dateGoFmt = config.customVars.dateGoFmt;
		in {
			autoquit = true;
			cleaner = "${ctpv}/ctpvclear";
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
			tabstop = 4;
			wrapscroll = true;
		};

		previewer.source = "${ctpv}/ctpv";

		extraConfig = ''
			&${ctpv}/ctpv -s $id
			&${ctpv}/ctpvquit $id
		'';
	};
}
