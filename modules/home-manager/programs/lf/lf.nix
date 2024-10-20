{ config, pkgs, lib, ... }:
{
	programs.lf = {
		commands.open = "$$OPENER \"$f\"";

		settings = let
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

			previewer = lib.mkIf config.custom.programs.tview.enable ''${pkgs.writers.writeDashBin "tviewlf" ''
				${config.custom.programs.tview.package}/bin/tview -w "$2" -h "$3" -x "$4" -y "$5" "$1"
			''}/bin/tviewlf'';
		};
	};

	xdg.configFile = lib.mkIf config.programs.lf.enable {
		"lf/guiIcons".source = ./guiIcons;
		"lf/ttyIcons".source = ./ttyIcons;
	};

	home = lib.mkIf config.programs.lf.enable {
		packages = [ pkgs.ncurses ];

		shellAliases.lf = "${pkgs.writers.writeDash "lfConf" ''
			set -eu

			[ "${"\${XDG_SESSION_TYPE:-}"}" = "tty" ] && \
				${pkgs.toybox}/bin/cat "${config.home.homeDirectory}/${config.xdg.configFile."lf/ttyIcons".target}" > "${config.xdg.configHome}/lf/icons" || \
				${pkgs.toybox}/bin/cat "${config.home.homeDirectory}/${config.xdg.configFile."lf/guiIcons".target}" > "${config.xdg.configHome}/lf/icons"

			${config.programs.lf.package}/bin/lf
		''}";
	};
}
