{ config, pkgs, ... }:
{
	programs.irssi = {
		networks.liberachat = {
			nick = "andrieee44";

			server = {
				address = "irc.libera.chat";
				port = 6697;
				autoConnect = true;
			};
		};

		extraConfig = ''
			chatnets = {
				liberachat = {
					sasl_username = "andrieee44";
					sasl_password = "PASSWORD";
					sasl_mechanism = "PLAIN";
				};
			};
		'';
	};

	home = {
		file.".irssi/config".target = "${config.xdg.configHome}/irssi/base.config";

		shellAliases.irssi = "${pkgs.writers.writeDash "irssiPass" ''
			set -eu

			${pkgs.gawk}/bin/awk -v pass="$(${pkgs.pass}/bin/pass web/liberachat)" '{
					sub("sasl_password = .*", "sasl_password = \"" pass "\";")
					print($0)
				}' "${config.home.homeDirectory}/${config.home.file.".irssi/config".target}" > "${config.xdg.configHome}/irssi/config"

			${pkgs.irssi}/bin/irssi --home "${config.xdg.configHome}/irssi" "$@"

			${pkgs.toybox}/bin/rm "${config.xdg.configHome}/irssi/config"
		''}";
	};
}
