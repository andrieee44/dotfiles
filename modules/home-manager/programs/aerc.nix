{ config, pkgs, lib, ... }:
{
	programs.aerc.extraConfig = {
		filters."text/plain" = "colorize";
		viewer.pager = config.home.sessionVariables.PAGER;

		general = {
			term = "linux";
			unsafe-accounts-conf = true;
		};

		ui = let
			dateGoFmt = "Jan _2 2006 (Mon) 3:04 PM";
		in {
			border-char-vertical = "│";
			border-char-horizontal = "─";
			timestamp-format = dateGoFmt;
			this-day-time-format = "";
			this-week-time-format = "";
			this-year-time-format = "";
			message-view-timestamp-format = dateGoFmt;
			dirlist-delay = "0s";
			styleset-name = "gui";
			fuzzy-complete = true;
			threading-enabled = true;
			show-thread-context = true;
		};
	};

	home = lib.mkIf config.programs.aerc.enable {
		file."${config.xdg.configHome}/aerc/aerc.conf".target = "${config.xdg.configHome}/aerc/base.conf";

		shellAliases.aerc = "${pkgs.writers.writeDash "aercConf" ''
			set -eu

			${pkgs.gawk}/bin/awk -v term="${"\${TERM}"}" -v tty="${"\${XDG_SESSION_TYPE:-}"}" '{
				sub("term = .*", "term = " term)

				if (tty == "tty") {
					sub("styleset-name = gui", "styleset-name = tty")
				}

				print($0)
			}' "${config.home.homeDirectory}/${config.home.file."${config.xdg.configHome}/aerc/aerc.conf".target}" > "${config.xdg.configHome}/aerc/aerc.conf"

			${config.programs.aerc.package}/bin/aerc "$@"
		''}";
	};
}
