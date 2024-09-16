{ config, pkgs, lib, ... }:
{
	programs.lf.settings = let
		dateGoFmt = "Jan _2 2006 (Mon) 3:04 PM";
	in {
		autoquit = true;
		drawbox = true;
		globsearch = true;
		hidden = true;
		icons = true;
		incfilter = true;
		infotimefmtnew = dateGoFmt;
		infotimefmtold = dateGoFmt;
		number = true;
		relativenumber = true;
		shell = "${pkgs.dash}/bin/dash";
		shellopts = "-eu";
		sixel = true;
		tabstop = 4;
		timefmt = dateGoFmt;
		waitmsg = "Press any key to continue...";
		wrapscroll = true;
	};

	xdg.configFile = {
		"lf/guiIcons" = {
			enable = config.programs.lf.enable;
			source = ./guiIcons;
		};

		"lf/ttyIcons" = {
			enable = config.programs.lf.enable;
			source = ./ttyIcons;
		};
	};

	home = lib.mkIf config.programs.lf.enable {
		packages = [ pkgs.ncurses ];

		shellAliases.lf = "${pkgs.writers.writeDash "lfConf" ''
			set -eu

			[ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] && \
				${pkgs.toybox}/bin/cat "${config.home.homeDirectory}/${config.xdg.configFile."lf/ttyIcons".target}" > "${config.xdg.configHome}/lf/icons" || \
				${pkgs.toybox}/bin/cat "${config.home.homeDirectory}/${config.xdg.configFile."lf/guiIcons".target}" > "${config.xdg.configHome}/lf/icons"

			${pkgs.lf}/bin/lf
		''}";
	};
}
