{ config, pkgs, lib, ... }:
{
	programs.aerc.extraConfig = {
		filters."text/plain" = "colorize";
		viewer.pager = config.home.sessionVariables.PAGER;

		general = {
			term = "linux";
			unsafe-accounts-conf = true;
		};

		ui = {
			border-char-vertical = "│";
			border-char-horizontal = "─";
			styleset-name = "default";
		};
	};

	home = lib.mkIf config.programs.aerc.enable {
		file."${config.xdg.configHome}/aerc/aerc.conf".target = "${config.xdg.configHome}/aerc/base.conf";

		shellAliases.aerc = "${pkgs.writers.writeDash "aercConf" ''
			set -eu

			${pkgs.gawk}/bin/awk -v term="${"\${TERM}"}" -v tty="${"\${XDG_SESSION_TYPE:-}"}" '{
				sub("term = .*", "term = " term)

				if (tty != "tty") {
					tty = "gui"
				}

				sub("styleset-name = .*", "styleset-name = ", tty)
				print($0)
			}' "${config.home.homeDirectory}/${config.home.file."${config.xdg.configHome}/aerc/aerc.conf".target}" > "${config.xdg.configHome}/aerc/aerc.conf"

			${config.programs.aerc.package}/bin/aerc "$@"
		''}";
	};
}
